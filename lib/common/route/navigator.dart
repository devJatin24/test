import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

//=============================================================================

void openScreenAsLeftToRight(BuildContext context, Widget targetWidget) =>
    openScreenAsPlatformWiseRoute(context, targetWidget, isFullScreen: false);

//=============================================================================

Future<void> openScreenAsBottomToTop(BuildContext context, Widget targetWidget,
        {bool isFullScreen = false}) async =>
    await Navigator.of(context)
        .push(AppRoute.createRoute(targetWidget, isFullScreen: isFullScreen));

//Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => targetWidget));

//=============================================================================

Future<dynamic> openScreenAsPlatformWiseRoute(
        BuildContext context, Widget targetWidget,
        {bool isFullScreen = false, bool isExit = false}) async =>
    isExit
        ? (Platform.isIOS
            ? Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                    builder: (BuildContext context) => targetWidget,
                    fullscreenDialog: isFullScreen),
                (route) => false)
            : Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => targetWidget,
                    fullscreenDialog: isFullScreen),
                (route) => false))
        : (Platform.isIOS
            ? Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => targetWidget,
                fullscreenDialog: isFullScreen))
            : Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => targetWidget,
                fullscreenDialog: isFullScreen)));
