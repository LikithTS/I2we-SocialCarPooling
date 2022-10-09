

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/Validation.dart';

import '../util/TextStylesUtil.dart';
import '../util/color.dart';
import '../util/constant.dart';

Widget inputEditTextWithPrefixWidget(BuildContext context,String textString,TextEditingController _controller,String errorText,IconData icon,int flag,InputValidationMixin inputValidationMixin,String initValue) =>  Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    elevation: 2,
    shadowColor: borderColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: _controller,
        decoration:  InputDecoration(
          prefixIcon: Icon(icon,color: primaryColor,),
          border: InputBorder.none,
          labelText: textString,
          labelStyle: TextStyleUtils.hintTextStyle,
          hintText: textString,
          hintStyle: TextStyleUtils.hintTextStyle,
        ),
        validator: (value) {
         // print('value $value :$flag : ${inputValidationMixin.isNameString(value)}');
          if (value!.isEmpty) {
            return errorText;
          }
          else if(flag==1 && inputValidationMixin.isNameString(value))
            {
              return Constant.nameError;
            }
          else if(flag==2 && !inputValidationMixin.isValidPhoneNumber(value))
            {
              return Constant.mobileValidError;
            }
          else if(flag==3 && !inputValidationMixin.isEmailValid(value))
            {
              return Constant.emailValidError;
            }
          return null;
        },
      ),
  ),
);


