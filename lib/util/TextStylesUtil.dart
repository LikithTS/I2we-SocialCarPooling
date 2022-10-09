import 'package:flutter/material.dart';

import 'color.dart';

abstract class TextStyleUtils {
  static const TextStyle primaryTextLight = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w300);

  static const TextStyle primaryTextItalic = TextStyle(
      fontFamily: 'Poppins',
      fontStyle: FontStyle.italic,
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w300);

  static const TextStyle primaryTextRegular = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w400);



  static const TextStyle primaryTextMedium = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w500);



  static const TextStyle primaryTextSemiBold = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w600);

  static const TextStyle primaryTextBold = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w700);

  static const TextStyle progressFooter = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 24,
      height: 0.5,
      fontWeight: FontWeight.w600);

  static const TextStyle hintTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: hintColor,
      fontSize: 14,
      height: 0.5,
      fontWeight: FontWeight.w300);
}
