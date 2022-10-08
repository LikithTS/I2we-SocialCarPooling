import 'package:flutter/material.dart';

Widget elevatedButtonView(String buttonName) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        minimumSize: const Size(200, 50)),
    onPressed: () {
      onRightButtonClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        fontFamily: 'PoppinsBold',
      ),
    ));

void onRightButtonClicked() {
  print("On right button clicked");
}