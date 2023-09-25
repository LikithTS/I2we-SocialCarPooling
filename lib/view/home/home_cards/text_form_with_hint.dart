

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/color.dart';

class TextFormWithHintSupport extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool isNumber;
  final int maxLen;
  TextEditingController updatedValue;

  TextFormWithHintSupport({
    Key? key,
    required this.text,
    required this.iconData,
    required this.isNumber,
    required this.maxLen,
    required this.updatedValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        keyboardType: checkForInputType(isNumber),
        textAlign: TextAlign.start,
        controller: updatedValue,
        maxLength: maxLen,
        decoration: InputDecoration(
            counterText: "",
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: text,
            hintStyle: const TextStyle(color: greyColor),
            prefixIcon: Icon(
              iconData,
              color: primaryColor,
            )),
      ),
    );
  }

  checkForInputType(bool isNumber) {
    if(isNumber) {
      return TextInputType.number;
    } else {
      TextInputType.text;
    }
  }
}