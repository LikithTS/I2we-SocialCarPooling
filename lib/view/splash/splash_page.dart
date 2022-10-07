import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';

import '../../util/string_url.dart';
import '../../widgets/image_widgets.dart';
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
              child:imageAssets(StringUrl.splashImage,Dimens().screenWidth,Dimens().screenWidth)),
            Container(
              margin: EdgeInsets.only(bottom: margin60.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  secondaryTextWidget(context,Constant.please_wait),
                  SizedBox(height: margin10.h,),
                  primaryTextWidget(context, Constant.working_task),
                ],
              ),
            )
          ],
        ));
  }
}
