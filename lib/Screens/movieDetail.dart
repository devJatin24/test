import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yc_test/common/route/navigator.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';
import 'package:yc_test/cubit/home/movies_cubit.dart';
import 'package:yc_test/model/Movie.dart';

import 'addMovieData.dart';

class MovieDetails extends StatefulWidget {
  MovieModel model;

  MovieDetails(this.model);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              height: size.height / 2,
              width: size.width,
              child: Stack(
                children: [
                  Container(
                    height: size.height / 2,
                    width: size.width,
                    child: Image.file(
                      File(widget.model.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        CupertinoIcons.back,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  DxTextBlack(
                    widget.model.name!,
                    mSize: 18,
                    mBold: true,
                    maxLine: 2,
                  ),
                  SizedBox(height: 5),
                  DxTextBlack("Director:- ${widget.model.directorName!}"),
                  SizedBox(height: 25),
                  DxTextBlack(
                    "Description",
                    mSize: 18,
                    mBold: true,
                  ),
                  SizedBox(height: 5),
                  DxTextBlack(
                    widget.model.description!,
                    maxLine: 1000,
                  ),
                  SizedBox(height: 35),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
