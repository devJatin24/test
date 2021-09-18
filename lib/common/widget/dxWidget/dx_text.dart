import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yc_test/common/app_utilities/dx_app_decoration.dart';
import 'package:yc_test/common/app_utilities/size_reziser.dart';
class DxTextWhite extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;

  DxTextWhite(this.mTitle, {this.mBold = false, this.mSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style: AppStyles.getTextStyleWhite(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextBlack extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;
  FontWeight fontWeight;
  TextOverflow overflow;
  int? maxLine;

  DxTextBlack(this.mTitle, {this.textAlign,this.maxLine =1,this.overflow = TextOverflow.ellipsis, this.mBold = false, this.mSize = 16, this.fontWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      overflow: overflow,
      maxLines: maxLine,
      style: this.mBold
          ? AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context), fontWeight: this.fontWeight)
          : AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
    );
  }
}

class DxText extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  Color textColor;
  TextAlign? textAlign;
  int maxLines;
  TextOverflow overflow;
  bool lineThrough ;

  DxText(this.mTitle,
      {this.mBold = false,
      this.maxLines = 1,
      this.textAlign,
      this.mSize = 16,
        this.lineThrough = false,
      this.overflow = TextOverflow.ellipsis,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return lineThrough ?Text(
      this.mTitle,
      style: AppStyles.getTextStrikeThrough(this.mBold, getSize(this.mSize, context), textColor: textColor, ),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    ):Text(
      this.mTitle,
      style: AppStyles.getTextStyle(this.mBold, getSize(this.mSize, context), color: textColor),
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class DxTextRed extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;

  DxTextRed(this.mTitle, {this.mBold = false, this.mSize = 16,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style: AppStyles.getTextStyleRed(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextGreen extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign? textAlign;
  DxTextGreen(this.mTitle, {this.mBold = false, this.mSize = 16,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      textAlign: textAlign,
      style: AppStyles.getTextStyleGreen(this.mBold, getSize(this.mSize, context)),
    );
  }
}

class DxTextPrimary extends StatelessWidget {
  String mTitle;
  bool mBold;
  double mSize;
  TextAlign textAlign;

  DxTextPrimary(this.mTitle, {this.mBold = false, this.mSize = 16, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.mTitle,
      style: AppStyles.getTextStylePrimary(this.mBold, getSize(this.mSize, context)),
      textAlign: textAlign,
    );
  }
}

class DxReachPrimary extends StatelessWidget {
  String mTitle;
  String mSubTitle;
  double mTitleSize;
  double mSubTitleSize;
  TextAlign textAlign;
  bool boldTitle;
  bool boldSubTitle;

  DxReachPrimary(this.mTitle,
      {this.mTitleSize = 17,
      this.mSubTitleSize = 14,
      this.textAlign = TextAlign.left,
      this.mSubTitle = "",
      this.boldTitle  = false,
      this.boldSubTitle = false}) {
    this.boldTitle = true;
    this.boldSubTitle = false;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: new TextSpan(
        style: AppStyles.getTextStylePrimary(false, getSize(this.mTitleSize, context)),
        children: <TextSpan>[
          new TextSpan(
              text: this.mTitle,
              style: new TextStyle(
                fontSize: this.mTitleSize,
                fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
              )),
          new TextSpan(
              text: this.mSubTitle,
              style: new TextStyle(fontSize: this.mSubTitleSize, fontWeight: boldSubTitle ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
