import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color,
    {double height = 1.0}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      height: height,
      decoration: TextDecoration.none,
      fontWeight: fontWeight);
}

// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color,double height=1}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color,height: height);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s13,
    required Color color,
    double height = 1.0}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color,
      height: height);
}

// Mediam text style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s15, required Color color,double height=1.0}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color,height: height);
}

// bold text style

TextStyle getBoldStyle({double fontSize = FontSize.s20, required Color color,double height = 1.0}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.medium,
    color,
    height: height
  );
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

// medium text style

