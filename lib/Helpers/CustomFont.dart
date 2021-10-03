import 'package:flutter/material.dart';

 class GetCustomFont {
  TextStyle getFont(int color, String fontName, double fontSize) {
    return new TextStyle(
      // set color of text
      color: Color(color),
      // set the font family as defined in pubspec.yaml
      fontFamily: fontName,
      // set the font size
      fontSize: fontSize,
    );
  }
}
