import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yc_test/database/dbManager.dart';
import 'package:yc_test/model/Movie.dart';

part 'update_data_base_state.dart';

class UpdateDataBaseCubit extends Cubit<UpdateDataBaseState> {
  UpdateDataBaseCubit() : super(UpdateDataBaseInitial());
  DbMovieManager dbmanager = new DbMovieManager();
  MovieModel? _model;
  ImagePicker imagePicker = ImagePicker();
  late String image;

  MovieModel get getModelData => _model!;

  void initData(MovieModel? model) {
    this._model = model ?? MovieModel();
    emit(UpdateDataBaseLoaded());
  }

  void onNameChanges(String _newName) {
    _model!.name = _newName;
  }

  void onMDirectorNameChanges(String _newName) {
    _model!.directorName = _newName;
  }

  void onDiscriptionChanges(String _newName) {
    _model!.description = _newName;
  }

  Future<void> getImage() async {
    try {
      emit(UpdateDataBaseLoading());

      XFile? _imagepPicker =
          await imagePicker.pickImage(source: ImageSource.gallery);
      image = _imagepPicker!.path;

      _model = MovieModel(image: image.toString());
      emit(UpdateDataBaseLoaded(model: _model));
    } catch (e, s) {
      print("Exception occured while getting image $e with stack $s");
      emit(UpdateDataBaseError("Image Not Selected!"));
    }
  }

  void addMovie(MovieModel model) {
    emit(UpdateDataBaseLoading());
    dbmanager
        .insertMovie(model)
        .then((id) => {this._model = model, print('Movie Added to Db ${id}')});
    emit(UpdateDataBaseLoaded(msg: "Data Add Successfully!"));
  }

  void updateMovie(MovieModel model) {
    emit(UpdateDataBaseLoading());
    dbmanager
        .updateMovie(model)
        .then((id) => {print('Movie Updated to Db ${id}')});
    emit(UpdateDataBaseLoaded(msg: "Data Update Successfully!"));
  }
}
