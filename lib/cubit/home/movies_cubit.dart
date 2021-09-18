import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yc_test/common/app_utilities/method_utils.dart';
import 'package:yc_test/database/dbManager.dart';
import 'package:yc_test/model/Movie.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());
  final DbMovieManager dbmanager = new DbMovieManager();
  late List<MovieModel> movies;


  void getMovies() async {
    emit(MoviesInitial());
    movies = await dbmanager.getMovieList();
    emit(MoviesLoaded(movies));
  }

  Future<void> refreshList() async {
    getMovies();
  }

  void deleteMovie(MovieModel model,BuildContext context) async {
    emit(MoviesLoading(movies));
    MethodUtils.showAlertDialog(context,"Delete","Are you Sure to Delete "
        "${model.name} movie?",
        callback: ()async{
          dbmanager.deleteMovie(model.id!);
          Navigator.pop(context);
          getMovies();

    });
    movies = await dbmanager.getMovieList();
    emit(MoviesLoaded(movies));

  }
}
