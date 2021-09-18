import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yc_test/common/app_utilities/dx_app_decoration.dart';

class DxDropDown extends StatelessWidget {
  String hintText;
  String valueText ="";
  Function() onClick;
  Icon? prefixIcon;
  bool readOnly ;
  TextEditingController? _controller;
  bool? isSemiBold = false;
  Color borderColor;
  Color fillColor;
  bool? isFilled = false;

  DxDropDown(
      {required this.hintText,
      required this.valueText,
      required this.onClick,
      this.isSemiBold,
      this.prefixIcon,
      this.fillColor = Colors.white,
      this.isFilled,
      this.borderColor = Colors.black,
      this.readOnly = false}) {
    _controller = TextEditingController(text: this.valueText);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: this.onClick,
      enabled: this.readOnly,
      tileColor: this.readOnly ? Colors.grey.shade200 : Colors.white,
      title: TextField(
        controller: _controller,
        enabled: false,
        autofocus: true,
        maxLines: 5,
        minLines: 1,
        style: AppStyles.getTextStyle(this.isSemiBold ?? false, 14),
        decoration: dxTextFieldDecoration(context,
            fillColor: fillColor,
            isFilled: isFilled,
            borderColor: borderColor,
            prefixIcon: prefixIcon,
            hint: this.hintText,
            textSize: 17,
            radius: 3,
            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp)),
      ),
    );
  }
}

class DxInputText extends StatefulWidget {
  String hintText;
  String? valueText = "";
  Function() ?onClick;
  Function() ?onTap;
  Function(String) ?onChanged;
  bool enabled;

  Widget? sufixIcon;
  TextEditingController? controller;
  bool isEditable;
  bool isUnderLine;
  TextInputType keyboardType;
  List<TextInputFormatter>? inputFormatters;
  int maxLines;
  int minLines;
  String? Function(String?)? validator;
  Icon? prefixIcon;
  bool showDefaultPrefixIcon;
  double? hintTextSize;
  bool autofocus;
  bool obscureText;
  bool isPreSelectedTextMode;
  bool readOnly;

  DxInputText({
    required this.hintText,
    required this.valueText ,
    this.onClick,
    this.hintTextSize,
    this.onChanged,
    this.readOnly = false,
    this.sufixIcon,
    this.enabled = true,
    this.isEditable = true,
    this.isUnderLine = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.showDefaultPrefixIcon = false,
    this.prefixIcon,
    this.autofocus = false,
    this.obscureText = false,
    this.isPreSelectedTextMode = false, this.onTap,
  }) {
    controller ??= TextEditingController();

//it will make sure cursor is at the last position.
    if(valueText != null && valueText!.isNotEmpty){
      print("NON BLANK CASE");
      controller!.value = TextEditingValue(
        text: valueText ?? "",
        selection: TextSelection.fromPosition(
          TextPosition(offset: valueText?.length ?? 0),
        ),
      );
    }else{
      print("BLANK CASE");
    }
    // controller.value = TextEditingValue(
    //   text: valueText ?? "",
    //   selection: TextSelection.fromPosition(
    //     TextPosition(offset: valueText?.length ?? 0),
    //   ),
    // );

//Enable this to show text field initially selected all text.
  }

  @override
  _DxInputTextState createState() => _DxInputTextState();
}

class _DxInputTextState extends State<DxInputText> {
  // FocusNode _focusNode;
  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode = FocusNode();
  //
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus && widget.isPreSelectedTextMode) {
  //       widget.controller.selection = TextSelection(
  //         baseOffset: 0,
  //         extentOffset: widget.valueText.length,
  //       );
  //     }
  //
  //     print("FocusOn=>${widget.hintText} => ${_focusNode.hasFocus}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("TEXT :-> ${widget.controller!.text}");
    return IgnorePointer(
//key: Key(this.hintText),
      ignoring: !widget.isEditable,
      child: InkWell(
        onTap: this.widget.onClick,
        child: TextFormField(
          obscureText: widget.obscureText,
          // focusNode: _focusNode,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          validator: widget.validator,
          minLines: this.widget.minLines,
          keyboardType: widget.maxLines > 1 ? TextInputType.multiline : widget.keyboardType,
          controller: widget.controller,
          inputFormatters: this.widget.inputFormatters,
          maxLines: this.widget.maxLines,
          enabled: this.widget.enabled,
          onSaved:(v){},
          onChanged: (query) {
            if (this.widget.onChanged != null) {
              this.widget.onChanged!(query);
            }
          },
          style: AppStyles.getTextStyle(false, 16),
          decoration: widget.isUnderLine
              ? InputDecoration(
                  hintText: this.widget.hintText,
                  hintStyle: Theme.of(context).textTheme.caption,
                )
              : dxTextFieldDecoration(context,
                  hintTextSize: widget.hintTextSize,
                  showDefaultPrefixIcon: widget.showDefaultPrefixIcon,
                  hint: this.widget.hintText,
                  textSize: 14,
                  radius: 3,
                  prefixIcon: this.widget.prefixIcon,
                  suffixIcon: this.widget.sufixIcon),
        ),
      ),
    );
  }
}
