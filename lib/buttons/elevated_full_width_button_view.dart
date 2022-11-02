import 'package:flutter/material.dart';

Widget elevatedDynamicWidthButtonView(String? buttonName, double width, void Function() onPostRideButtonClicked) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        minimumSize: Size(width, 40)),
    onPressed: () {
      onPostRideButtonClicked.call();
    },
    child: Text(
      buttonName!,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.2,
        fontFamily: 'PoppinsBold',
      ),
    ));