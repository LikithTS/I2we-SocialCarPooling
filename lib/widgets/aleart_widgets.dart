import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/CPString.dart';

void alertWidgets(BuildContext context, String? title, String? message) =>
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text(title!),
            content: Text(message!),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text(CPString.ok),
                ),
              ),
            ],
          ),
    );

Future<void> showAlertDialog(BuildContext context, String title,
    String message, String btnText1, String btnText2,
    VoidCallback? onBtn1Pressed, VoidCallback? onBtn2Pressed) async {
  return showDialog<void>(
    context: context,
    builder: (ctx) =>
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: onBtn1Pressed,
              child: Text(btnText1),
            ),
            TextButton(
              onPressed: onBtn2Pressed,
              child: Text(btnText2),
            ),
          ],
        ),
  );
}

void showSnackbar(BuildContext context, String message) {
  var snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
