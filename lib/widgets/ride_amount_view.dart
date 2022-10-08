
import 'package:flutter/material.dart';

Widget rideAmountView(int amount) => Text(
  '\u{20B9}${amount.toString()}',
  style: const TextStyle(
    color: Colors.green,
    fontSize: 21,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    fontFamily: 'Poppins',
  ),
  maxLines: 1,
  textAlign: TextAlign.center,
);