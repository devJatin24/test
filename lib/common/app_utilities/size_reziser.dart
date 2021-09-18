import 'package:flutter/cupertino.dart';

double getSize(double size, BuildContext context) {
  double nSize = size;
  double width = MediaQuery.of(context).size.width;
  print("your device width is $width and ${MediaQuery.of(context).size.shortestSide}");
  if (width <= 320) {
    nSize = size * 0.6;
  } else if (width > 320 && width <= 375) {
    nSize = size * 0.75;
  } else if (width > 375 && width < 480) {
    nSize = size * 0.85;
  } else if (width > 500 && width < 900) {
    nSize = size * 1.1;
  } else {
    nSize = size * 1.1;
  }
  return nSize;
}
