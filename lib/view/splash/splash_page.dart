import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';
import 'package:socialcarpooling/font&margin/margin_confiq.dart';
import 'package:socialcarpooling/provider/PushNotification.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/FirebaseNotification.dart';
import 'package:socialcarpooling/util/FirebaseTokenUpdate.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/intro/intro_main_page.dart';
import 'package:socialcarpooling/view/profile/util/GetProfileDetails.dart';
import 'package:socialcarpooling/widgets/NotificationBadge.dart';

import '../../util/string_url.dart';
import '../../widgets/image_widgets.dart';
import '../../widgets/text_widgets.dart';
import '../login/login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String? mToken = '';
  FirebaseTokenUpdate firebaseTokenUpdate = FirebaseTokenUpdate();
  FirebaseNotification firebaseNotification = FirebaseNotification();

  @override
  void initState() {
    firebaseNotification.registerNotification();
    firebaseNotification.handleBackgroundNotification();
    firebaseNotification.checkForInitialMessage();
    if (CPSessionManager().isUserLoggedIn()) {
      GetProfileDetails(context);
    }
    handleNextPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      Provider.of<DriverProvider>(context, listen: false).changeDriver(false);
    });
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
}

getNextPage() {
  if (CPSessionManager().isUserLoggedIn()) {
    return HomePage(homeRepository: HomeRepository());
  } else if (CPSessionManager().isIntroPageVisited()) {
    return LoginScreen(userRepository: LoginRepository());
  } else {
    return const IntoMainPage();
  }
}

void handleNextPage(BuildContext context) {
  Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop, child: getNextPage())));
}
