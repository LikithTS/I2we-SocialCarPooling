
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

Material buildMaterialForm(
    BuildContext context,
    String labelText,
    IconData prefixIcon,
    IconData suffixIcon,
    TextEditingController textController) {
  return Material(
    elevation: 2.0,
    child: TextField(
      textCapitalization: TextCapitalization.characters,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: primaryColor),
        suffixIcon: Icon(
          suffixIcon,
          color: primaryColor,
        ),
      ),
    ),
  );
}