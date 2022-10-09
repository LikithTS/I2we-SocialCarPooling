
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget imageAssets(String url,double width,double height) =>Image.asset(
  url,
  width: width.w,height: height.h,
);