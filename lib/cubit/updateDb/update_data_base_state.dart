part of 'update_data_base_cubit.dart';

abstract class UpdateDataBaseState {}

class UpdateDataBaseInitial extends UpdateDataBaseState {
  @override
  List<Object> get props => [];
}

class UpdateDataBaseLoaded extends UpdateDataBaseState {
  String? msg;
  MovieModel? model;

  UpdateDataBaseLoaded({this.msg, this.model});

  @override
  List<Object> get props => [];
}

class UpdateDataBaseLoading extends UpdateDataBaseState {
  @override
  List<Object> get props => [];
}

class UpdateDataBaseError extends UpdateDataBaseState {
  String Error;

  UpdateDataBaseError(this.Error);

  @override
  List<Object> get props => [Error];
}
