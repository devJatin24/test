import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yc_test/common/app_utilities/method_utils.dart';
import 'package:yc_test/common/constant/appMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void validFromServer(String email, String password) async {
    try {
      emit(LoginLoading());
      if (await MethodUtils.isInternetPresent()) {
        if (email.isEmpty) {
          emit(LoginError("Please Enter your Email-id"));
        } else if (password.isEmpty) {
          emit(LoginError("Please Enter your Password"));
        } else {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          emit(LoginLoaded("Login Success"));
        }
      } else {
        emit(LoginError(AppMessages.getNoInternetMsg));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  void signup(String email, String password) async {
    try {
      emit(LoginLoading());
      if (await MethodUtils.isInternetPresent()) {
        if (email.isEmpty) {
          emit(LoginError("Please Enter your Email-id"));
        } else if (password.isEmpty) {
          emit(LoginError("Please Enter your Password"));
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          emit(LoginLoaded("Account Successfully Created!"));
        }
      } else {
        emit(LoginError(AppMessages.getNoInternetMsg));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
