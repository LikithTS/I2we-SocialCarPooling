import 'package:common/network/repository/LoginRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/margin_confiq.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/intro/intro_page.dart';
import 'package:socialcarpooling/view/login/login_screen.dart';

import '../../util/CPSessionManager.dart';

class IntoMainPage extends StatelessWidget {
  const IntoMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroPage(
      pages: <Widget>[
        Container(
            margin: EdgeInsets.only(top: margin110),
            width: margin390.w,
            height: margin390.h,
            padding: EdgeInsets.all(margin20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageSlide(StringUrl.introOne),
                SizedBox(
                  height: margin10,
                ),
                headerText(CPString.welcome),
                SizedBox(
                  height: margin10,
                ),
                smallText(CPString.tempText)
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: margin110),
            width: margin390.w,
            height: margin390.h,
            padding: EdgeInsets.all(margin20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imageSlide(StringUrl.introTwo),
                SizedBox(
                  height: margin10,
                ),
                headerText(CPString.saveFuel),
                SizedBox(
                  height: margin10,
                ),
                smallText(CPString.tempText)
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: margin110),
            width: margin390.w,
            height: margin390.h,
            padding: EdgeInsets.all(margin20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imageSlide(StringUrl.introThree),
                SizedBox(
                  height: margin10,
                ),
                headerText(CPString.SaveEnvironment),
                SizedBox(
                  height: margin10,
                ),
                smallText(CPString.tempText)
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: margin110),
            width: margin390.w,
            height: margin390.h,
            padding: EdgeInsets.all(margin20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imageSlide(StringUrl.introFour),
                SizedBox(
                  height: margin10.h,
                ),
                headerText(CPString.makeFriends),
                SizedBox(
                  height: margin10.h,
                ),
                smallText(CPString.tempText)
              ],
            )),
      ],
      onIntroCompleted: () {
        CPSessionManager().onIntroPageVisited(true);
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: LoginScreen(userRepository: LoginRepository())));
      },
    );
  }

  Widget imageSlide(String url) => Image.asset(url,
      width: introImageWidth, height: introImageHeight, fit: BoxFit.cover);

  Widget smallText(String text) => Expanded(
        child: Text(
          text,
          style: TextStyleUtils.primaryTextRegular,
          maxLines: 3,
        ),
      );

  Widget headerText(String title) => Container(
          child: Align(
        alignment: Alignment.topLeft,
        child: Text(title, style: TextStyleUtils.primaryTextBold),
      ));
}
