import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/sign_up/welcome_page.dart';

import '../../util/CPString.dart';
import '../../font&margin/margin_confiq.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: deviceWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Icon(Icons.check,size: 160,color: Colors.white,),
                ),
              ),
              const SizedBox(height: 20,),
              Text(CPString.thankYou,style: TextStyleUtils.primaryTextBold.copyWith(fontSize: fontSize27),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              Text(CPString.registrationSuccess,style: TextStyleUtils.primaryTextMedium.copyWith(fontSize: fontSize20),textAlign: TextAlign.center,),
              Container(
                width: deviceWidth(context),
                margin: const EdgeInsets.only(left: 30,right: 30,top: 70,bottom: 10),
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child:WelcomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(margin16),
                    ),
                    elevation: margin2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      CPString.continueString,
                      style: TextStyle(fontSize: fontSize18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
