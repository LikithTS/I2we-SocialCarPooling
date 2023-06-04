import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

class CustomDialog extends StatefulWidget {
  final String title, descriptions, rightButtonText, leftButtonText;
  final String img;

  const CustomDialog(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.rightButtonText,
      required this.leftButtonText,
      required this.img})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: greyColor, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            widget.img,
            width: 115,
            height: 116,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.descriptions,
            style: TextStyle(fontSize: 14, color: primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    widget.leftButtonText,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.rightButtonText,
                      style: const TextStyle(fontSize: 14),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
