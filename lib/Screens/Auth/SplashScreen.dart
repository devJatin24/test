import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yc_test/Screens/Auth/loginScreen.dart';
import 'package:yc_test/Screens/homeScreen.dart';
import 'package:yc_test/common/app_utilities/app_images.dart';
import 'package:yc_test/common/route/navigator.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';

class SplashScreen extends StatelessWidget {

  void navigateInside(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      openScreenAsPlatformWiseRoute(context,HomeScreen(userLogin: true,),isExit:
      true);
    } else {
      openScreenAsPlatformWiseRoute(context,LoginScreen(),isExit: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () => navigateInside(context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.applogo),
            SizedBox(height: 15),
            DxTextBlack(
              "Yellow class Assesment",
              mSize: 18,
              mBold: true,
            )
          ],
        ),
      ),
    );
  }
}
