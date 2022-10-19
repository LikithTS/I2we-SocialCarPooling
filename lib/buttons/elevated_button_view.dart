import 'package:flutter/material.dart';

Widget elevatedButtonView(String buttonName) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        minimumSize: const Size(150, 40)),
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
  print("On right button clicked");
}