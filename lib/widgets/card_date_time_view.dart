import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';

Widget timeViewGreen(IconData icons, String dateTime) => Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Container(
              alignment: Alignment.center,
              child: Icon(icons, color: Colors.green),
            ),
          ),
          WidgetSpan(
            child: Text(dateTime,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyleUtils.primaryTextRegular.copyWith(
                  color: Colors.green,
                  fontSize: fontSize13,
                  letterSpacing: 1,
                )),
          ),
        ],
      ),
    );

Widget timeView(IconData icons, String dateTime) => Column(
      children: [
        Icon(icons, color: primaryColor),
        Text(dateTime,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyleUtils.primaryTextRegular.copyWith(
              color: textGreyColor,
              fontSize: fontSize13,
              letterSpacing: 1,
            )),
      ],
    );

