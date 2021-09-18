import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yc_test/common/app_utilities/app_theme.dart';
import 'package:yc_test/common/app_utilities/method_utils.dart';
import 'package:yc_test/common/route/navigator.dart';
import 'package:yc_test/common/widget/app_circular_loader.dart';
import 'package:yc_test/common/widget/dxWidget/dx_input_fields.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';
import 'package:yc_test/cubit/auth/login/login_cubit.dart';

import '../homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameControoler = TextEditingController();
  TextEditingController passControoler = TextEditingController();
  late Size size;
  late LoginCubit cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;

  void toggleLogin(bool v) => setState(() => this.isLogin = v);
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: materialPrimaryColor,
    primary: materialPrimaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  @override
  void dispose() {
    userNameControoler.dispose();
    passControoler.dispose();
    super.dispose();
  }

  void navigateInside(BuildContext context) async {
    openScreenAsPlatformWiseRoute(context,HomeScreen(userLogin: true,),isExit:
    true);

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    cubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: materialPrimaryColor,
      body:BlocConsumer<LoginCubit, LoginState>(
          builder: (BuildContext context, state) {
            if (state is LoginLoaded) {
              return body();
            }
            if (state is LoginError) {
              return body();
            }
            if (state is LoginInitial) {
              return body();
            }
            if (state is LoginLoading) {
              return Stack(
                children: [body(), AppLoaderProgress()],
              );
            }

            return Container();
          }, listener: (BuildContext context, state) {
        if (state is LoginLoaded) {
          MethodUtils.showSnackBarGK(_scaffoldKey, "${state.msg}");
          Future.delayed(Duration(seconds:1), () => navigateInside(context));
        }
        if (state is LoginError) {
          MethodUtils.showSnackBarGK(_scaffoldKey, "${state.error}");
        }
      }),

    );
  }

  Widget body(){
    return Column(children: [
      Container(
        color: materialPrimaryColor,
        height: size.height*.3,
        width: size.width,
        alignment: Alignment.center,
        child: DxTextWhite("Yc Assesment ",mBold: true,mSize: 25,),
      ),
      Expanded(child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(25),
                topLeft:Radius.circular(25) )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: DxTextBlack("Welcome Back !",mSize: 18,mBold: true,)),
              SizedBox(height: 25),
              Container(
                height:75,
                child: DxInputText(
                  prefixIcon: Icon(Icons.mail),
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  controller: userNameControoler,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  valueText: userNameControoler.text,
                  hintText: 'Email-Id',
                ),
                color: Colors.white,
              ),

              SizedBox(height: 15),
              Container(
                height: 75,
                child: DxInputText(
                  prefixIcon: Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  controller: passControoler,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  valueText: passControoler.text,
                  hintText: 'Password',
                  obscureText: true,
                ),
                color: Colors.white,
              ),
              SizedBox(height: 5),
              SwitchListTile(value: isLogin, onChanged: toggleLogin, title: Text("Signup?"),),
              SizedBox(height: 25),
              Container(
                width: size.width*0.7,
                child: ElevatedButton(
                  onPressed: () {
                    !this.isLogin ?   cubit.validFromServer
                      (userNameControoler.text, passControoler.text):cubit.signup
                      (userNameControoler.text, passControoler.text);
                  },
                  style: raisedButtonStyle,
                  child: DxTextWhite(
                    !this.isLogin ? "Login" : "SignUp",
                    mBold: true,
                    mSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(onPressed:()=> openScreenAsPlatformWiseRoute(context,HomeScreen(),isExit: true), child: DxTextBlack("Skip",
                mSize: 18,mBold: true,))

            ],),
        ),
      ))
    ],);
  }


}
