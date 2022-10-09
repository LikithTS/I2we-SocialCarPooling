import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/color.dart';
import '../utils/Localization.dart';

Widget primaryTextWidget(BuildContext context, String? text) => Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text!,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontFamily: 'Poppins',
            overflow: TextOverflow.ellipsis,
          )),
    ));

Widget secondaryTextWidget(BuildContext context, String? text) => Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text!,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: primaryColor,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins')),
    ));

Widget primaryThemeTextWidget(BuildContext context, String? text) => Container(
  child: Text(text! ,
      style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
          color: textThemeColor,
          decoration: TextDecoration.none,
          fontFamily: 'Poppins')),
);

Widget primaryThemeTextNormal(BuildContext context, String? text) => Container(
  child: Text(text!,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: textThemeColor,
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
      )),
);

Widget primaryTextNormalTwoLine(BuildContext context, String? text) => Container(
  child: Text(text!,
    style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: textGreyColor,
      decoration: TextDecoration.none,
      fontFamily: 'Poppins',
      overflow: TextOverflow.ellipsis,
    ),
    maxLines: 2,
  ),
);

Widget primaryTextNormal(BuildContext context, String? text) => Center(
  child: Align(
    alignment: Alignment.topLeft,
    child: Expanded(
      child: Text(
        text!,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: textGreyColor,
            decoration: TextDecoration.none,
            fontFamily: 'Poppins'),
        maxLines: 3,
      ),
    ),
  ),
);


