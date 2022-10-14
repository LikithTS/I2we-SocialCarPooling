import 'package:flutter/material.dart';

Widget outlineButtonView(String buttonName) => OutlinedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        minimumSize: const Size(150, 40)),
    onPressed: () {
      onCancelButtonClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(color: Colors.blue),
    ));

void onCancelButtonClicked() {
  print("On Cancelled button clicked");
}