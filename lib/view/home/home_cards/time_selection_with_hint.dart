import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialcarpooling/util/color.dart';

class TimeSelectionWithHintSupport extends StatelessWidget {
  final String text;
  final IconData iconData;
  TextEditingController timerValue;

  TimeSelectionWithHintSupport(
      {Key? key,
      required this.text,
      required this.iconData,
      required this.timerValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: greyColor, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextField(
        textAlign: TextAlign.start,
        controller: timerValue,
        readOnly: true,
        onTap: () {
          showClock(context);
        },
        decoration: InputDecoration(
            fillColor: greyColor,
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

  Future<void> showClock(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color(primaryColor.value),
              colorScheme:
                  ColorScheme.light(primary: Color(primaryLightColor.value)),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          ),
        );
      },
    );

    var timeSelected = pickedTime?.format(context);
    log("Picked Time $timeSelected");
    if (timeSelected != null) {
      var df = DateFormat('HH:mm');
      var selectedTime = df.parse(timeSelected);
      timerValue.text = DateFormat("h:mm a").format(selectedTime);
    } else {
      timerValue.text = "";
    }
  }
}
