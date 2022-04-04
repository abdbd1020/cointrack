import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonUI.dart';

class GeneralActionButton extends StatelessWidget {
  final bool isProcessing;
  final void Function() callBackOnSubmit;
  final String title;
  final EdgeInsetsGeometry padding;
  final double height;
  final double minWidth;
  final Color color;
  final Color textColor;
  final double textFontSize;
  final FontWeight fontWeight;
  final bool showNextIcon;

  GeneralActionButton(
      {this.isProcessing,
        this.callBackOnSubmit,
        this.height,
        this.title,
        this.color,
        this.padding,
        Key key,
        this.textColor,
        this.textFontSize,
        this.showNextIcon,
        this.minWidth,
        this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(25, 5, 25, 5),
      alignment: Alignment.center,
      child: MaterialButton(
        height: height ?? 40,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0.0)),
        minWidth: minWidth ?? double.infinity,
        onPressed: () => (isProcessing == false) ? callBackOnSubmit() : () {},
        child: buildChild(),
        color: getButtonColor(),
      ),
    );
  }

  Widget buildChild() {
    if (showNextIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomText(
            title,
            fontSize: 16,
            color: Colors.white,
          ),
          Icon(
            Icons.chevron_right,
            size: 28.0,
            color: Colors.white,
          ),
        ],
      );
    }

    return CustomText(
      title,
      fontSize: textFontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? Colors.white,
    );
  }

  Color getButtonColor() {
    if (isProcessing == false) {
      if (color == null) {
        return Colors.black;
      } else {
        return color;
      }
    }
    return Colors.grey;
  }
}
