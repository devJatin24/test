part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  String msg;

  LoginLoaded(this.msg);

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  String error;

  LoginError(this.error);

  @override
  List<Object> get props => [];
}
