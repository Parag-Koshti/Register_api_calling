import 'package:flutter/material.dart';

class Appwidget {
  static Widget text({
    String? title,
    TextAlign? align,
    double? fontSize,
    String? family,
    Color? tColor,
    FontWeight? textWeight,
    int? maxLine,
    TextOverflow? overflowDot,
  }) {
    return Text(
      title!,
      textAlign: align ?? TextAlign.start,
      overflow: overflowDot,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: 'AppFont',
        fontSize: fontSize ?? 20,
        fontWeight: textWeight ?? FontWeight.w300,
        color: tColor ?? Colors.black,
        // letterSpacing: 0.06,
      ),
    );
  }
}
