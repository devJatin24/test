import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLoaderProgress extends StatelessWidget {
  const AppLoaderProgress();

  @override
  Widget build(BuildContext context) {
    bool isAndroid = defaultTargetPlatform == TargetPlatform.android;

    return Container(
      color: Colors.black12,
      child: new Center(
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: isAndroid
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                )
              : CupertinoActivityIndicator(
                  radius: 20,
                ),
        ),
      ),
    );

  }
}
