import 'package:flutter/material.dart';

Widget textViewBold(String textName) => Text(
  textName,
  style: const TextStyle(
    color: Colors.lightBlue,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    fontFamily: 'Poppins',
  ),
  textAlign: TextAlign.start,
);