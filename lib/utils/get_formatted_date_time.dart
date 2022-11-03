import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

String getFormattedDateTime(DateTime dateTime) {
  final formattedStr = formatDate(
      dateTime, [dd, '-', mm, '-', yyyy, ' ', HH, ':', nn, ' ', am]);
  debugPrint("Formatted date time object $formattedStr");
  return formattedStr;
}

String getFormattedDate(DateTime dateTime) {
  final formattedStr = formatDate(
      dateTime, [dd, '-', mm, '-', yyyy]);
  debugPrint("Formatted date object $formattedStr");
  return formattedStr;
}

String getFormattedTime(DateTime dateTime) {
  final formattedStr = formatDate(
      dateTime, [HH, ':', nn, ' ', am]);
  debugPrint("Formatted time object $formattedStr");
  return formattedStr;
}

DateTime parseDatetimeFromUtc({required String isoFormattedString}){
  var dateTime = DateTime.parse(isoFormattedString);
  return dateTime.toLocal();
}