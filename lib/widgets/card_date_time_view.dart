import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/font_size.dart';

Widget timeView(IconData icons, String dateTime) => Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 6),
              child: Icon(icons, color: textThemeColor),
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Text(dateTime,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyleUtils.primaryTextRegular.copyWith(
                  color: textGreyColor,
                  fontSize: fontSize13,
                  letterSpacing: 1.0,
                )),
          ),
        ],
      ),
    );
