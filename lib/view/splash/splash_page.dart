import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/text_widgets.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Image.asset(
            'assets/images/splash_image.png',
            width: 100.w,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 40.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              secondaryTextWidget(context,'Please Wait'),
              SizedBox(height: 10.h,),
              primaryTextWidget(context, 'Working on the task'),
            ],
          ),
        )
      ],
    ));
  }
}
