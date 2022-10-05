import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/text_widgets.dart';
import '../intro/intro_main_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child:IntoMainPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash_image.png',
                width: 118.w,height: 122.h,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60.h),
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
