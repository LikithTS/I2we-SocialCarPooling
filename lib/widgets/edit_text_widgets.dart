import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/Validation.dart';

import '../util/CPString.dart';
import '../util/TextStylesUtil.dart';
import '../util/color.dart';

Widget inputEditTextWithPrefixWidget(
        BuildContext context,
        String textString,
        TextEditingController _controller,
        String errorText,
        IconData icon,
        int flag,
        int maxLength,
        InputValidationMixin inputValidationMixin,
        String initValue) =>
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      shadowColor: borderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: _controller,
          keyboardType: flag == 2 && flag == 4
              ? TextInputType.number
              : TextInputType.text,
          maxLength: maxLength,
          decoration: InputDecoration(
            fillColor: Colors.white,
            counterText: "",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            prefixIcon: Icon(
              icon,
              color: primaryColor,
            ),
            border: InputBorder.none,
            labelText: textString,
            labelStyle: TextStyleUtils.hintTextStyle,
            hintText: textString,
            hintStyle: TextStyleUtils.hintTextStyle,
          ),
          validator: (value) {
            // print('value $value :$flag : ${inputValidationMixin.isNameString(value)}');
            /*  if (value!.isEmpty) {
            return errorText;
          }*/
            if (flag == 1 && inputValidationMixin.isNameString(value)) {
              return CPString.nameError;
            } else if (flag == 2 &&
                !inputValidationMixin.isValidPhoneNumber(value)) {
              return CPString.mobileValidError;
            } else if (flag == 4 && !inputValidationMixin.isZipValid(value!)) {
              return CPString.zipCodeError;
            }
            /*else if(flag==3 && !inputValidationMixin.isEmailValid(value))
            {
              return CPString.emailValidError;
            }
          else if(flag==4 && !inputValidationMixin.isZipValid(value))
            {
              return CPString.zipCodeError;
            }
          else if(flag==5 && inputValidationMixin.isNullString(value))
            {
              return CPString.stringError;
            }*/
            return null;
          },
        ),
      ),
    );

TextFormField buildFormBuilderTextField(
    String labelText, String hintText, TextEditingController _controller,
    [TextInputType? textInputType = TextInputType.name,
    FormFieldValidator? formFieldValidator]) {
  return TextFormField(
    controller: _controller,
    keyboardType: textInputType,
    validator: formFieldValidator,
    decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder()),
  );
}

TextFormField buildFormBuilderMultilineTextField(
    String labelText,
    String hintText,
    TextEditingController _controller,
    int maxLines,
    int maxLength,
    [TextInputType? textInputType = TextInputType.name,
    FormFieldValidator? formFieldValidator]) {
  return TextFormField(
    textAlign: TextAlign.start,
    controller: _controller,
    keyboardType: textInputType,
    validator: formFieldValidator,
    maxLines: maxLines,
    maxLength: maxLength,
    decoration: InputDecoration(
        counterText: "",
        labelText: labelText,
        hintText: hintText,
        hintTextDirection: TextDirection.ltr,
        border: const OutlineInputBorder()),
  );
}
