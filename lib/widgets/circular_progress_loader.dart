import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/font&margin/margin_confiq.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';

Widget getLoadingWidget() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        addVerticalSpace(margin20),
        const Text(CPString.LOADING),
      ],
    ),
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: margin12),
            child: const Text(CPString.LOADING)),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
