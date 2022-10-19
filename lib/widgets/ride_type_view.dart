
import 'package:flutter/material.dart';

Widget rideTypeView(String? rideType) =>  Text(
  rideType!,
  style: const TextStyle(
    color: Colors.pinkAccent,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    fontFamily: 'Poppins',
  ),
  maxLines: 1,
  textAlign: TextAlign.center,
);