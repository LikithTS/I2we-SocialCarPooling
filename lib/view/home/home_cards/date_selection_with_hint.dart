
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialcarpooling/util/color.dart';

class DateSelectionWithHintSupport extends StatelessWidget {
  final String text;
  final IconData iconData;

  DateSelectionWithHintSupport({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  var dateValue = TextEditingController();

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
      child: TextField(
        textAlign: TextAlign.start,
        controller: dateValue,
        readOnly: true,
        onTap: () {
          showClock(context);
        },
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: text,
            prefixIcon: Icon(
              iconData,
              color: primaryLightColor,
            )),
      ),
    );
  }

  Future<void> showClock(BuildContext context) async {
    var currentDate = DateTime.now();
    var lastDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
    DateTime? pickedDate = await showDatePicker(
        context: context, //context of current state
        initialDate: currentDate,
        firstDate: currentDate, //DateTime.now() - not to allow to choose before today.
        lastDate: lastDate,
    );
    if(pickedDate != null ){
      log("Date choosen $pickedDate");  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      log("Formatted Date $formattedDate"); //formatted date output using intl package =>  2021-03-16
      dateValue.text = formattedDate;
    }
  }
}