import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yc_test/Screens/Auth/loginScreen.dart';
import 'package:yc_test/common/app_utilities/app_images.dart';
import 'package:yc_test/common/app_utilities/app_theme.dart';
import 'package:yc_test/common/app_utilities/method_utils.dart';
import 'package:yc_test/common/route/navigator.dart';
import 'package:yc_test/common/widget/app_circular_loader.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';
import 'package:yc_test/cubit/home/movies_cubit.dart';
import 'package:yc_test/database/dbManager.dart';
import 'package:yc_test/model/Movie.dart';

import 'addMovieData.dart';
import 'movieDetail.dart';

class HomeScreen extends StatefulWidget {
  bool userLogin =false;
  HomeScreen({this.userLogin = false});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbMovieManager dbmanager = new DbMovieManager();
  late MoviesCubit cubit;
  late BuildContext c;

  ButtonStyle raisedButtonStyle(MaterialColor color) =>
      ElevatedButton.styleFrom(
        onPrimary: color,
        primary: color,
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      );

  @override
  void initState() {
    cubit = BlocProvider.of<MoviesCubit>(context);
    cubit.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    c = context;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: DxTextWhite(
          "Movies",
          mBold: true,
          mSize: 18,
        ),
        actions: [
      widget.userLogin ?  IconButton(
              onPressed: () {
                MethodUtils.showAlertDialog(
                    context,
                    "Logout",
                    "Are you Sure you "
                        "want to Logout?", callback: () {
                  FirebaseAuth.instance.signOut();
                  openScreenAsPlatformWiseRoute(context, LoginScreen(),
                      isExit: true);
                });
              },
              icon: Icon(Icons.logout)) : SizedBox.shrink()
        ],
      ),
      body: BlocConsumer<MoviesCubit, MoviesState>(
          builder: (BuildContext context, state) {
        if (state is MoviesInitial) {
          return AppLoaderProgress();
        } else if (state is MoviesError) {
          return mainBody([]);
        } else if (state is MoviesLoaded) {
          return mainBody(state.movies!);
        } else if (state is MoviesLoading) {
          return Stack(
            children: [mainBody(state.movies!), AppLoaderProgress()],
          );
        }

        return Container();
      }, listener: (BuildContext context, state) {
        if (state is MoviesError) {
          // MethodUtils.showSnackBarGK(_scaffoldKey, "${state.Error}");
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: materialPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          openScreenAsBottomToTop(context, AddMovie()).then((value) => cubit.getMovies());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget mainBody(List<MovieModel> movies) {
    return movies.length == 0
        ? Center(child: DxTextBlack("No Data"))
        : RefreshIndicator(
            onRefresh: cubit.refreshList,
            child: ListView.builder(
                itemCount: movies == null ? 0 : movies.length,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  MovieModel _model = movies[index];
                  return itemBody(_model);
                }),
          );
  }

  Widget itemBody(MovieModel model) {
    return GestureDetector(
      onTap: () => openScreenAsBottomToTop(context, MovieDetails(model)),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(model.image!),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DxTextBlack(
                    "${model.name}",
                    maxLine: 2,
                    mBold: true,
                    mSize: 18,
                  ),
                  SizedBox(height: 4),
                  DxText(
                    "Director Name:- ${model.directorName}",
                    textColor: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  DxTextBlack(
                    "${model.description}",
                    maxLine: 2,
                  ),
                  SizedBox(height: 8),
                  widget.userLogin ?  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: raisedButtonStyle(Colors.green),
                        child: DxTextWhite(
                          "Edit",
                          mBold: true,
                          mSize: 18,
                        ),
                        onPressed: () {
                          openScreenAsBottomToTop(
                              c,
                              AddMovie(
                                title: "Update",
                                model: model,
                              )).then((value) => cubit.getMovies());
                        },
                      ),
                      ElevatedButton(
                        style: raisedButtonStyle(Colors.red),
                        child: DxTextWhite(
                          "Delete",
                          mBold: true,
                          mSize: 18,
                        ),
                        onPressed: () {
                          BlocProvider.of<MoviesCubit>(c)
                              .deleteMovie(model, c);
                        },
                      ),
                    ],
                  ) : SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
