import 'package:common/network/repository/HomeRepository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/questionarie/questionarie_view.dart';

import '../../util/CPString.dart';
import '../../util/TextStylesUtil.dart';
import '../../util/color.dart';
import '../../util/dimens.dart';
import '../../util/margin_confiq.dart';
import '../../util/string_url.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
          margin: EdgeInsets.only(top: margin110),
          width: deviceWidth(context),
          height: deviceHeight(context),
          padding: EdgeInsets.all(margin20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              imageSlide(StringUrl.welecomeImage),
              SizedBox(
                height: margin10,
              ),
              headerText(CPString.hiUserName),
              SizedBox(
                height: margin10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: smallText(
                    CPString.welcometempText),
              ),
              SizedBox(
                height: margin30,
              ),
              smallText(
                  CPString.takeMinute),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(CPString.no,_gotoHomePage),
                    _buildButton(CPString.yes,_gotoBioPage),
                  ],
                ),
              )

            ],
          )),
    );
  }

  Widget imageSlide(String url) =>
      Image.asset(url, width: introImageWidth, height: introImageHeight, fit: BoxFit.cover);

  Widget smallText(String text) => Expanded(
    child: Text(
      text,
      style: TextStyleUtils.primaryTextRegular,
      maxLines: 3,
    ),
  );

  Widget headerText(String title) => Container(
      margin: EdgeInsets.symmetric(horizontal: margin30.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: TextStyleUtils.primaryTextBold),
      ));

  Widget _buildButton(String title,VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin10)
          ),
        ), // <-- Radius
        primary: title==CPString.no?Colors.white:primaryLightColor,
        textStyle: TextStyleUtils.primaryTextRegular,
        side: title==CPString.no?BorderSide(width: 1.0,color: borderColor):BorderSide(width:0,color: primaryLightColor),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: margin12,right: margin12),
        child: Text(
          title,
          style: TextStyleUtils.primaryTextRegular.copyWith(color: title==CPString.no?borderColor:Colors.white),
        ),
      ),
      onPressed: callback,
    );
  }
  void _gotoBioPage() {
    const snackBar = SnackBar(
      content: Text(CPString.yet_to_be_impl),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _gotoHomePage() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        QuestionariePage()), (Route<dynamic> route) => false);
  }
}
