
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/font_size.dart';

import '../util/TextStylesUtil.dart';
import '../util/color.dart';
import '../util/margin_confiq.dart';

Widget primaryButton(String title,VoidCallback callback) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin10)
        ),
      ), // <-- Radius
      primary: Colors.white,
      textStyle: TextStyleUtils.primaryTextRegular,
      side: BorderSide(width:0,color: primaryLightColor),
    ),
    child: Padding(
      padding:  EdgeInsets.only(left: margin12,right: margin12),
      child: Text(
        title,
        style: TextStyleUtils.primaryTextRegular.copyWith(color: primaryColor,fontSize: fontSize9),
      ),
    ),
    onPressed: callback,
  );
}
Widget secondaryButton(String title,VoidCallback callback) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin10)
        ),
      ), // <-- Radius
      primary: primaryColor,
      textStyle: TextStyleUtils.primaryTextRegular,
      side: BorderSide(width: 1.0,color: borderColor),
    ),
    child: Padding(
      padding:  EdgeInsets.only(left: margin12,right: margin12),
      child: Text(
        title,
        style: TextStyleUtils.primaryTextRegular.copyWith(color:Colors.white),
      ),
    ),
    onPressed: callback,
  );
}