import 'package:flutter/widgets.dart';

import 'dx_text.dart';

class DxCenterText extends StatelessWidget {
  String? displayText = "";
  DxCenterText({this.displayText}) {
    this.displayText ??= "Record not found";
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: DxText(displayText!, mSize: 18));
  }
}
