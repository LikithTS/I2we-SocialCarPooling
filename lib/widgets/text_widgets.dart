import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/util/font_size.dart';

import '../util/color.dart';

Widget headerTextWidget(BuildContext context,String text) =>Container(
   child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:fontSize17,fontWeight: FontWeight.w500,color: Colors.black,decoration: TextDecoration.none,fontFamily: Constant.fontFamilyPoppins)),
    )
);

Widget primaryTextWidget(BuildContext context,String text) =>Container(
   child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:fontSize17,fontWeight: FontWeight.w500,color: Colors.black,decoration: TextDecoration.none,fontFamily: Constant.fontFamilyPoppins)),
    )
);

Widget secondaryTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:fontSize20,fontWeight: FontWeight.w800,color: primaryColor,decoration: TextDecoration.none,fontFamily: Constant.fontFamilyPoppins)),
    )
);
Widget teritaryTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:fontSize20,fontWeight: FontWeight.w800,color: primaryColor,decoration: TextDecoration.none,fontFamily: Constant.fontFamilyPoppins)),
    )
);


