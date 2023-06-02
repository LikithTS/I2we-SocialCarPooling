
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/Localization.dart';

alertDialogView(BuildContext context, String id) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(DemoLocalizations.of(context)
              ?.getText(id) ??
              ""),
          actions: <Widget>[
            TextButton(
              child:
              Text(DemoLocalizations.of(context)?.getText("ok") ?? ""),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}


errorAlertDialogView(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Retrieve the text the that user has entered by using the
          // TextEditingController.
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child:
              Text(DemoLocalizations.of(context)?.getText("ok") ?? ""),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}