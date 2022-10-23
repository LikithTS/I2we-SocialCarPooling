import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/CPString.dart';

void alertWidgets(BuildContext context, String? title,String? message) =>
    showDialog(
  context: context,
  builder: (ctx) => AlertDialog(
    title:  Text(title!),
    content:  Text(message!),
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

