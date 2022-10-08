import 'package:flutter/material.dart';

Widget timeView(IconData icons, String dateTime) => Text.rich(
  TextSpan(
    children: [
      WidgetSpan(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 10),
          child: Icon(icons),
        ),
      ),
      WidgetSpan(
        child: Text(dateTime,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.2,
              fontFamily: 'Poppins',
            ),
        ),
      ),
    ],
  ),
);
