import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  final formattedStr = formatDate(
      dateTime, [dd, '-', mm, '-', yyyy, ' ', HH, ':', nn, ' ', am]);
  debugPrint("Formatted date time object $formattedStr");
  return formattedStr;
}

DateFormat getDateTimeFormatter(){
  DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  return dateFormat;
}

String getFormattedDate(DateTime dateTime) {
  var formatter = DateFormat('dd-MM-yyyy');
  String formattedDate = formatter.format(dateTime);
  debugPrint("Formatted date object $formattedDate");
  return formattedDate;
}

String getFormattedTime(DateTime dateTime) {
  String formattedTime = DateFormat('kk:mm:a').format(dateTime);
  debugPrint("Formatted time object $formattedTime");
  return formattedTime;
}

DateTime parseDatetimeFromUtc({required String isoFormattedString}){
  var dateTime = DateTime.parse(isoFormattedString);
  return dateTime.toLocal();
}

bool checkForPreviousDate(DateTime date) {
  DateTime now = DateTime.now();
  var difference =  DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  if(difference >= 0) {
    return false;
  }
  return true;
}
