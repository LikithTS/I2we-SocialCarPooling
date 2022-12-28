import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

Widget elevatedButtonView(String buttonName, VoidCallback onClicked, [Color btnBgColor = buttonBgColor]) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor : btnBgColor
    ),
    onPressed: () {
      onClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.2,
        fontFamily: 'PoppinsBold',
      ),
    ));

Widget elevatedFullWidthButtonView(String buttonName, VoidCallback onClicked, [Color btnBgColor = buttonBgColor]) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor : btnBgColor,
        minimumSize: const Size(double.infinity, 40)
    ),
    onPressed: () {
      onClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.2,
        fontFamily: 'PoppinsBold',
      ),
    ));
