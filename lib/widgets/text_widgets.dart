import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/color.dart';

Widget primaryTextWidget(BuildContext context,String text) =>Container(
   child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:17.sp,fontWeight: FontWeight.w500,color: Colors.black,decoration: TextDecoration.none,fontFamily: 'Poppins')),
    )
);

Widget secondaryTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:20.sp,fontWeight: FontWeight.w800,color: primaryColor,decoration: TextDecoration.none,fontFamily: 'Poppins')),
    )
);

Widget primaryThemeTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:17.sp,fontWeight: FontWeight.bold,color: textThemeColor,decoration: TextDecoration.none,fontFamily: 'Poppins')),
    )
);

