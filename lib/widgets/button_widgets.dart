import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';

import '../util/TextStylesUtil.dart';
import '../util/color.dart';
import '../font&margin/margin_confiq.dart';

Widget primaryButton(String title, VoidCallback callback) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin10)),
      ), // <-- Radius
      backgroundColor: Colors.white,
      textStyle: TextStyleUtils.primaryTextMedium,
      side: BorderSide(width: 0, color: primaryLightColor),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: margin12, right: margin12),
      child: Text(
        title,
        style: TextStyleUtils.primaryTextMedium
            .copyWith(color: primaryColor, fontSize: fontSize9),
      ),
    ),
    onPressed: callback,
  );
}

Widget secondaryButton(String title, VoidCallback callback) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin5)),
      ), // <-- Radius
      backgroundColor: primaryColor,
      minimumSize: const Size.fromHeight(50),
      textStyle: TextStyleUtils.primaryTextRegular,
    ),
    onPressed: callback,
    child: Padding(
      padding: EdgeInsets.only(left: margin12, right: margin12),
      child: Text(
        title,
        style: TextStyleUtils.primaryTextRegular.copyWith(color: Colors.white),
      ),
    ),
  );
}

Widget primaryButtonWithCallBack(String title, VoidCallback callback) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin5)),
        ), // <-- Radius
        backgroundColor: primaryColor,
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
