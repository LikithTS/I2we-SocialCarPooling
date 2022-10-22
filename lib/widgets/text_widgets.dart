import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/font_size.dart';

import '../util/color.dart';

Widget primaryTextWidget(BuildContext context, String? text) => Container(
        child: Align(
      alignment: Alignment.center,
      child: Text(text!,
          style: TextStyle(
            fontSize: fontSize17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontFamily: CPString.fontFamilyPoppins,
            overflow: TextOverflow.ellipsis,
          )),
    ));

Widget secondaryTextWidget(BuildContext context, String? text) => Container(
        child: Align(
      alignment: Alignment.center,
      child: Text(text!,
          style: TextStyle(
              fontSize: fontSize20,
              fontWeight: FontWeight.w800,
              color: primaryColor,
              decoration: TextDecoration.none,
              fontFamily: CPString.fontFamilyPoppins)),
    ));

Widget primaryThemeTextWidget(BuildContext context, String? text) => Container(
      child: Text(text!,
          style: TextStyle(
              fontSize: fontSize16,
              fontWeight: FontWeight.normal,
              color: textThemeColor,
              decoration: TextDecoration.none,
              fontFamily: CPString.fontFamilyPoppins)),
    );

Widget primaryThemeTextNormal(BuildContext context, String? text) => Container(
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: textThemeColor,
          decoration: TextDecoration.none,
          fontFamily: CPString.fontFamilyPoppins,
        ),
        maxLines: 2,
      ),
    );

Widget primaryTextNormalTwoLine(BuildContext context, String? text) =>
    Container(
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: textGreyColor,
          decoration: TextDecoration.none,
          fontFamily: CPString.fontFamilyPoppins,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
    );

Widget primaryTextNormal(BuildContext context, String? text) => Center(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text!,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: textGreyColor,
              decoration: TextDecoration.none,
              fontFamily: CPString.fontFamilyPoppins),
          maxLines: 3,
        ),
      ),
    );

Widget primaryTextSmall(BuildContext context, String? text) => Center(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text!,
          style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.normal,
              color: textGreyColor,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins'),
          maxLines: 1,
        ),
      ),
    );

Widget secondaryTextSmall(BuildContext context, String? text) => Center(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text!,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: textGreyColor,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins'),
          maxLines: 1,
        ),
      ),
    );

Widget primaryTextWidgetLeft(BuildContext context, String? text) => Container(
        child: Align(
      alignment: Alignment.topLeft,
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

Widget primaryBigTextWidget(BuildContext context, String? text, Color color) =>
    Container(
      child: Text(text!,
          style: TextStyle(
              fontSize: fontSize33,
              fontWeight: FontWeight.normal,
              color: color,
              decoration: TextDecoration.none,
              fontFamily: CPString.fontFamilyPoppins)),
    );

Widget primaryTextLightWidgetLeft(BuildContext context, String? text) =>
    Container(
        child: Align(
      alignment: Alignment.topLeft,
      child: Text(text!,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w100,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontFamily: 'Poppins',
            overflow: TextOverflow.ellipsis,
          )),
    ));
