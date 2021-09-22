import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:yc_test/cubit/auth/login/login_cubit.dart';
import 'Screens/Auth/SplashScreen.dart';
import 'common/app_utilities/app_theme.dart';
import 'cubit/home/movies_cubit.dart';
import 'cubit/updateDb/update_data_base_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light));
    return MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: defaultAppThemeData,
        home: SplashScreen(),
        // home: BottomNavigationScreen(),
      ),
    );
  }
}

class BlocManager {
  static List<BlocProviderSingleChildWidget> get blocProviders => [
        BlocProvider(create: (context) => UpdateDataBaseCubit()),
        BlocProvider(create: (context) => MoviesCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ];
}
