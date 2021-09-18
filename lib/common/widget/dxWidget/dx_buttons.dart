import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yc_test/common/app_utilities/app_theme.dart';
import 'package:yc_test/common/app_utilities/dx_app_decoration.dart';
import 'package:yc_test/common/app_utilities/size_reziser.dart';
import 'dx_text.dart';

class DxCancelButton extends StatelessWidget {
  final Function() onClicked;
  final String buttonText;
  final Color buttonBgColor;
  DxCancelButton({required this.onClicked, required this.buttonText, this.buttonBgColor= Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(48.0, 48.0),
        backgroundColor: buttonBgColor == null ? primaryRed : primaryRed,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        buttonText,
        style: AppStyles.getTextStyleColor(false, getSize(18, context), fontWeight: FontWeight.bold, textColor: Colors.white),
      ),
      onPressed: onClicked,
    );
  }
}

class DxFlatButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color bgColor;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry? padding;
  final Color borderColor;
  const DxFlatButton(
      {required Key key ,
      required this.onPressed,
      required this.text,
      this.borderColor = Colors.black, 
        this.padding,
      this.bgColor =  Colors.white,
      this.textColor = Colors.white,
      required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension * 0.9,
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          textStyle: TextStyle(fontSize: textSize != null ? getSize(16, context) : getSize(textSize, context)),
          backgroundColor: bgColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.black87, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: AppStyles.getTextStyleColor(false, getSize(18, context),
              fontWeight: FontWeight.bold, textColor: textColor ?? Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DxFlatButtonAccent extends StatelessWidget {
  final Function() onPressed;
  final String text;

  DxFlatButtonAccent({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension * 0.9,
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.green.shade500, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(2)),
        ),
        child: Text(
          text,
          style: AppStyles.getTextStyleColor(false, getSize(18, context), fontWeight: FontWeight.bold, textColor: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DxFlatButtonPrimary extends StatelessWidget {
  final Function() onPressed;
  final String text;

  DxFlatButtonPrimary({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension * 0.9,
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: AppStyles.getTextStyleColor(false, getSize(18, context), fontWeight: FontWeight.bold, textColor: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DxFlatButtonWhite extends StatelessWidget {
  final Function() onPressed;
  final String text;

  DxFlatButtonWhite({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension * 0.9,
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: AppStyles.getTextStyleColor(false, getSize(18, context), fontWeight: FontWeight.bold, textColor: Colors.black87),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DxFlatButtonRed extends StatelessWidget {
  final Function()onPressed;
  final String text;

  DxFlatButtonRed({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension * 0.9,
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          text,
          style: AppStyles.getTextStyleColor(false, getSize(18, context), fontWeight: FontWeight.bold, textColor: Colors.red),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

/*
* Custom Buttons to be used inside the whole app as wrapper to native ones
* if needed modify here, or replicate it here only.
* */

//--------------------- Text Button --------------------------
class DxOutlineButton extends StatelessWidget {
  final Function()onPressed;
  final String btnTitle;
  // final Color color;
  final Color textColor;

  const DxOutlineButton(
      {required Key key,
      this.textColor = Colors.white,
      // this.color,
      required this.onPressed,
      required this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: TextStyle(color: textColor),
      ),
      style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4.0),
              side: BorderSide(width: 1, color: textColor, style: BorderStyle.solid)))),
    );
  }
}

//--------------------- Text Icon button --------------------------
class DxTextButtonIcon extends StatelessWidget {
  final Function() onPressed;
  final String btnTitle;
  final Widget icon;

  const DxTextButtonIcon({required Key key, required this.icon, required this.onPressed, required this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(btnTitle),
      icon: icon,
    );
  }
}

//--------------------- Text Icon button --------------------------
class DxTextButton extends StatelessWidget {
  final Function()onPressed;
  final String btnTitle;
  final isBold;

  const DxTextButton({required Key key, required this.onPressed, required this.btnTitle, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: DxText(
        btnTitle,
        mBold: this.isBold,
      ),
    );
  }
}

//--------------------- Text Icon button --------------------------
class DxOutlineButtonIcon extends StatelessWidget {
  final Function()onPressed;
  final String btnTitle;
  final Widget icon;
  final Color borderColor;
  final Color textColor;
  final double fontSize;

  const DxOutlineButtonIcon(
      {required Key key,
      this.textColor = Colors.white,
      this.borderColor = Colors.black,
      this.fontSize = 16,
      required this.icon,
      required this.onPressed,
      required this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      style: OutlinedButton.styleFrom(side: BorderSide(color: borderColor), padding: EdgeInsets.zero),
      onPressed: onPressed,
      label: DxText(
        btnTitle,
        textColor: textColor,
        mSize: fontSize,
      ),
      icon: icon,
    );
  }
}

class DxElevatedButton extends StatelessWidget {
  final Function()onPressed;
  final String btnTitle;

  const DxElevatedButton({required Key key, required this.onPressed, required this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(btnTitle));
  }
}

class DxOutlinedButton extends StatelessWidget {
  final Function()onPressed;
  final String btnTitle;
  final Color bgColor;

  const DxOutlinedButton({required Key key, required this.onPressed, required this.btnTitle,  this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: DxText(btnTitle),
        style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade50, primary: Colors.teal));
  }
}
