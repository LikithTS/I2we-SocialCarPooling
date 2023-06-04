
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

Widget rideTypeView(String? rideType) =>  Text(
  rideType!,
  style: const TextStyle(
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    fontFamily: 'Poppins',
  ),
  maxLines: 1,
  textAlign: TextAlign.center,
);