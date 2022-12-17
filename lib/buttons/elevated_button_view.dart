import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

Widget elevatedButtonView(String buttonName, [Color btnBgColor = buttonBgColor]) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        minimumSize: const Size(150, 40),
        backgroundColor : btnBgColor
    ),
    onPressed: () {
      onRightButtonClicked();
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

void onRightButtonClicked() {
  log("On right button clicked");
}
