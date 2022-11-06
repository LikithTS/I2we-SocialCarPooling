import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';

import '../util/TextStylesUtil.dart';

Widget headerLayout(BuildContext context, String text) => Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 15,
          ),
          Text(text,
              style: TextStyleUtils.primaryTextBold
                  .copyWith(color: primaryColor))
        ],
      ),
    );
