import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../util/TextStylesUtil.dart';


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
            borderSide: BorderSide(width: 1, color: primaryColor),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: greyColor),
          labelText: labelText,
          labelStyle: TextStyleUtils.hintTextStyle,
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
