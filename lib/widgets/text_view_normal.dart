import 'package:flutter/material.dart';

Widget textViewNormal(String textName) => Text(
      textName,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.2,
        fontFamily: 'Poppins',
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
    );
