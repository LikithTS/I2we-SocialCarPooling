import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialcarpooling/util/color.dart';

import '../util/TextStylesUtil.dart';

Widget headerLayout(BuildContext context,String text) =>  Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(onTap:(){
          Navigator.of(context).pop();
          },child: SvgPicture.asset('assets/svgimages/arrow_left.svg')),
      ),
      SizedBox(width: 10,),
      Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(text, style: TextStyleUtils.primaryTextBold.copyWith(color: primaryColor)))
    ],
  ),
);
