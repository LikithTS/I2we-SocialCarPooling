import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/color.dart';
import '../util/margin_confiq.dart';

Widget primaryButtonWithCallBack(String title, VoidCallback callback) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin5)),
        ), // <-- Radius
        primary: primaryLightColor,
        textStyle: TextStyle(
            fontSize: 20.sp, fontFamily: 'assets/fonts/poppins_medium.ttf'),
        side: const BorderSide(width: 0, color: primaryLightColor),
      ),
      onPressed: callback,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: 'assets/fonts/poppins_medium.ttf'),
        ),
      ),
    );
