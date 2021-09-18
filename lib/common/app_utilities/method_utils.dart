import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:yc_test/common/widget/dxWidget/dx_text.dart';


class MethodUtils {


  static void showSnackBar(BuildContext ctx, msgToDisplay) {
    print(msgToDisplay);

    var snackBar = SnackBar(
      content: Text(msgToDisplay),
    );

    Scaffold.of(ctx).showSnackBar(snackBar);
  }

  static void showSnackBarGK(
      GlobalKey<ScaffoldState> globalScaffoldKey, msgToDisplay) {
    print(msgToDisplay);

    var snackBar = SnackBar(content:Text(msgToDisplay));

    globalScaffoldKey.currentState!.showSnackBar(snackBar);
  }

  static void showAlertDialog(
      BuildContext context, String mTitle, String mContent, {Function()?
      callback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: DxTextBlack(mTitle,mSize: 18,mBold: true,),
          content: DxTextBlack(mContent,maxLine: 3,),
          actions: <Widget>[
             TextButton(
              child: new DxTextBlack("Yes"),
              onPressed: callback
            ),

             TextButton(
              child: new DxTextBlack("No"),
              onPressed: () {
                Navigator.of(context).pop();
                callback;
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> isInternetPresent() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        print("Connected to Mobile Network");

        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        print("Connected to WiFi");
        return true;
      } else {
        print("Unable to connect. Please Check Internet Connection");
        return false;
      }
    } on SocketException catch (_) {
      //print('not connected');
      return false;
    }
  }
}
