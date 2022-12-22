import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Material buildMaterialForm(
    BuildContext context,
    String hint,
    String labelText,
    IconData prefixIcon,
    IconData suffixIcon,
    TextEditingController textController,
    String? Function(String?)? formValidator,
    bool isPasswordField,
    bool isNumber,
    FocusNode focusNode
    ) {
  return Material(
    elevation: 2.0,
    child: TextFormField(
      controller: textController,
      focusNode: focusNode,
      keyboardType:TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10)
      ],
      textAlign: TextAlign.start,
      validator: formValidator,
      decoration: InputDecoration(
          fillColor: Colors.grey,
          counterText: "",
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
          hintText: hint,
          labelText: labelText,
          suffixIcon: IconButton(
            iconSize: 30,
            icon: Icon(suffixIcon),
            color: Colors.green,
            onPressed: () {
              // Do nothing
            },
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          )),
    ),
  );
}
