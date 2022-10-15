import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/intro/intro_main_page.dart';
import 'package:socialcarpooling/view/intro/intro_page.dart';
import 'package:socialcarpooling/view/map/location_page.dart';
import 'package:socialcarpooling/view/sign_up/sign_up_page.dart';

import '../../util/string_url.dart';
import '../../widgets/image_widgets.dart';
import '../../widgets/text_widgets.dart';
import '../map/search_location_view.dart';

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
                child:HomePage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child:imageAssets(StringUrl.splashImage,splashImageWidth,splashImageHeight)),
            Container(
              margin: EdgeInsets.only(bottom: margin60.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  secondaryTextWidget(context,CPString.please_wait),
                  SizedBox(height: margin10.h,),
                  primaryTextWidget(context, CPString.working_task),
                ],
              ),
            )
          ],
        ));
  }
}
