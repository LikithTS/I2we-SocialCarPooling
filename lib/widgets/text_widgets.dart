import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/color.dart';

Widget primaryTextWidget(BuildContext context,String text) =>Container(
   child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:17.sp,fontWeight: FontWeight.w700,color: Colors.black)),
    )
);

Widget secondaryTextWidget(BuildContext context,String text) =>Container(
    child: Align(
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(fontSize:20.sp,fontWeight: FontWeight.bold,color: primaryColor)),
    )
);


