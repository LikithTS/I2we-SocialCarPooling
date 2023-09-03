import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

Widget outlineButtonView(String buttonName, VoidCallback onClicked) => OutlinedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        side: const BorderSide(color: greyColor)),
    onPressed: () {
      onClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(color: primaryColor),
    ));

Widget outlineFullButtonView(String buttonName, VoidCallback onClicked) => OutlinedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        minimumSize: const Size(200, 40),
        side: const BorderSide(color: greyColor)),
    onPressed: () {
      onClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(color: primaryColor),
    ));

// Don't remove this below function

// outlineButtonView(leftButtonText, () {}),
// Widget outlineButtonView(String buttonName, VoidCallback onClick) =>
//     OutlinedButton(
//         style: ElevatedButton.styleFrom(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//             ),
//             minimumSize: const Size(150, 40)),
//         onPressed: () {
//           onClick;
//         },
//         child: Text(
//           buttonName,
//           style: const TextStyle(color: primaryColor),
//         ));
