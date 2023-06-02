

import 'package:flutter/material.dart';

import '../../../util/color.dart';

class TextFormWithHintSupport extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool isNumber;
  TextEditingController updatedValue;

  TextFormWithHintSupport({
    Key? key,
    required this.text,
    required this.iconData,
    required this.isNumber,
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
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: text,
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