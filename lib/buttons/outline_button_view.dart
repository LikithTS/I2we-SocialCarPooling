import 'dart:developer';

import 'package:common/network/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/constant.dart';

Widget outlineButtonView(String buttonName, VoidCallback onClicked) => OutlinedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        side: const BorderSide(color: Colors.grey)),
    onPressed: () {
      onClicked();
    },
    child: Text(
      buttonName,
      style: const TextStyle(color: Colors.blue),
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
//           style: const TextStyle(color: Colors.blue),
//         ));
