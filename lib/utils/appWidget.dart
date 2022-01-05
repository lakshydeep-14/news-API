import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'constants.dart';
import 'colors.dart';

Widget text(
  String text, {
  var fontWeight = FontWeight.normal,
  var fontSize = textSizeLargeMedium,
  Color textColor = normal_txt_color,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.underline : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color borderColor = Colors.transparent,
    Color shColor = Colors.transparent,
    Color fillColor = c_white,
    var showShadow = false}) {
  return BoxDecoration(
    color: fillColor,
    boxShadow: showShadow
        ? defaultBoxShadow(
            shadowColor: shColor.withOpacity(0.4),
            offset: const Offset(2.0, 2.0))
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

String dateParsed({required DateTime dateTime}) {
  return DateFormat('yyyy-MM-dd').format(dateTime).toString();
}
