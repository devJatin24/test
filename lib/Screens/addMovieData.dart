import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yc_test/Screens/homeScreen.dart';
import 'package:yc_test/common/app_utilities/app_theme.dart';
import 'package:yc_test/common/app_utilities/method_utils.dart';
import 'package:yc_test/common/route/navigator.dart';
import 'package:yc_test/common/widget/app_circular_loader.dart';
import 'package:yc_test/common/widget/dxWidget/dx_input_fields.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';
import '../cubit/updateDb/update_data_base_cubit.dart';
import 'dart:io';

import 'package:yc_test/database/dbManager.dart';
import 'package:yc_test/model/Movie.dart';

class AddMovie extends StatefulWidget {
  String title;
  MovieModel? model;

  AddMovie({this.title = "Add", this.model});

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  File? _image;
  late Size size;
  late UpdateDataBaseCubit cubit;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController directorNameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    cubit = BlocProvider.of<UpdateDataBaseCubit>(context);
    nameController.addListener(() {
      cubit.onNameChanges(nameController.text);
    });
    directorNameController.addListener(() {
      cubit.onMDirectorNameChanges(directorNameController.text);
    });
    descriptionController.addListener(() {
      cubit.onDiscriptionChanges(descriptionController.text);
    });
    cubit.initData(widget.model);
    InitializeFields();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    directorNameController.dispose();
    super.dispose();
  }

  void InitializeFields() {
    if (widget.model != null) {
      nameController.text = widget.model!.name!;
      descriptionController.text = widget.model!.description!;
      directorNameController.text = widget.model!.directorName!;
      _image = File(widget.model!.image!);
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: materialPrimaryColor,
    primary: materialPrimaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: DxTextWhite(
          "${widget.title} Movie",
          mBold: true,
          mSize: 18,
        ),
      ),
      body: BlocConsumer<UpdateDataBaseCubit, UpdateDataBaseState>(
          builder: (BuildContext context, state) {
        if (state is UpdateDataBaseLoaded) {
          return body();
        } else if (state is UpdateDataBaseError) {
          return body();
        } else if (state is UpdateDataBaseInitial) {
          return AppLoaderProgress();
        } else if (state is UpdateDataBaseLoading) {
          return Stack(
            children: [body(), AppLoaderProgress()],
          );
        }

        return Container();
      }, listener: (BuildContext context, state) {
        if (state is UpdateDataBaseError) {
          MethodUtils.showSnackBarGK(_scaffoldKey, "${state.Error}");
        } else if (state is UpdateDataBaseLoaded) {
          if (state.msg != null) {
            nameController.clear();
            directorNameController.clear();
            descriptionController.clear();
            cubit.getModelData.image = null;
            MethodUtils.showSnackBarGK(_scaffoldKey, "${state.msg}");
            Future.delayed(Duration(seconds: 1),
                () => Navigator.pop(context));
          }
        }
      }),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          children: [
            InkWell(
              onTap: () => cubit.getImage(),
              child: Container(
                height: 200,
                width: size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: (cubit.getModelData.image == null
                      ? Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        )
                      : Image.file(
                          File(cubit.getModelData.image!),
                          fit: BoxFit.cover,
                        )),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              height: 75,
              child: DxInputText(
                keyboardType: TextInputType.text,
                autofocus: false,
                controller: nameController,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                valueText: nameController.text,
                hintText: 'Movie Name',
              ),
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Container(
              height: 75,
              child: DxInputText(
                keyboardType: TextInputType.text,
                autofocus: false,
                controller: directorNameController,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                valueText: directorNameController.text,
                hintText: 'Director Name',
              ),
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Container(
              height: 75,
              child: DxInputText(
                keyboardType: TextInputType.text,
                autofocus: false,
                minLines: 4,
                maxLines: 1000,
                controller: descriptionController,
                inputFormatters: [LengthLimitingTextInputFormatter(2000)],
                valueText: descriptionController.text,
                hintText: 'Description',
              ),
              color: Colors.white,
            ),
            SizedBox(height: 35),
            Container(
              width: size.width * 0.7,
              child: ElevatedButton(
                onPressed: widget.title == "Add" ? insertData : updateData,
                style: raisedButtonStyle,
                child: widget.title == "Add"
                    ? DxTextWhite(
                        "Save",
                        mBold: true,
                        mSize: 18,
                      )
                    : DxTextWhite(
                        "Update",
                        mBold: true,
                        mSize: 18,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertData() {
    MovieModel model = new MovieModel(
        name: nameController.text,
        description: descriptionController.text,
        image: cubit.getModelData.image,
        directorName: directorNameController.text);
    cubit.addMovie(model);
  }

  void updateData() {
    MovieModel model = new MovieModel(
        name: nameController.text,
        description: descriptionController.text,
        image: cubit.getModelData.image,
        id: widget.model!.id!,
        directorName: directorNameController.text);
    cubit.updateMovie(model);
  }
}
