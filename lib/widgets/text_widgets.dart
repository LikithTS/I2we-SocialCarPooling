import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget primaryTextWidget(BuildContext context,String text) =>Container(
   child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
    )
);

Widget secondaryTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:16.sp,fontWeight: FontWeight.w700,color: Colors.blue)),
    )
);


