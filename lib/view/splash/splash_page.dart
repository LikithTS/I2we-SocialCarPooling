import 'dart:async';

import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/intro/intro_main_page.dart';
import 'package:socialcarpooling/view/login/login_screen.dart';
import 'package:socialcarpooling/view/sign_up/welcome_page.dart';

import '../../util/CPSessionManager.dart';
import '../../util/string_url.dart';
import '../../widgets/image_widgets.dart';
import '../../widgets/text_widgets.dart';

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
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: getNextPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
            child: imageAssets(
                StringUrl.splashImage, splashImageWidth, splashImageHeight)),
        Container(
          margin: EdgeInsets.only(bottom: margin60.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              secondaryTextWidget(context, CPString.please_wait),
              SizedBox(
                height: margin10.h,
              ),
              primaryTextWidget(context, CPString.working_task),
            ],
          ),
        )
      ],
    ));
  }

  getNextPage() {
   /* if (CPSessionManager().isUserLoggedIn()) {
      return HomePage(homeRepository: HomeRepository());
    } else if (CPSessionManager().isIntroPageVisited()) {
      return LoginScreen(userRepository: LoginRepository());
    } else {
      return const IntoMainPage();
    }*/
    return const WelcomePage();

  }
}
