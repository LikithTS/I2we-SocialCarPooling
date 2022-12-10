import 'dart:async';

import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/user/UserProfileData.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/AppPreference.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/intro/intro_main_page.dart';

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
  @override
  void initState() {
    super.initState();

    getUserApi();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: getNextPage())));
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

  getNextPage() {
    if (CPSessionManager().isUserLoggedIn()) {
      return HomePage(homeRepository: HomeRepository());
    } else if (CPSessionManager().isIntroPageVisited()) {
      return LoginScreen(userRepository: LoginRepository());
    } else {
      return const IntoMainPage();
    }
  }
}

handleResponseData(value) {
  if (value is UserProfileData) {
    AppPreference().userProfileData = value;

    //print("Response Data : ${value.statusCode}");
  } else {
    print("UPdate failure " + value.toString());
    // ErrorResponse errorResponse = value;
    // setState(() {
    //   errorText = errorResponse.errorMessage.toString();
    // });
    //  print("Response Data : Error");

  }
}

void getUserApi() {
  Future<dynamic> future = UpdateUserRepository().getUserProfileDetails();
  future.then((value) => {handleResponseData(value)});
}
