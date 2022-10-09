import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/home/home_page.dart';

import '../../util/constant.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';

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
        child: Container(
          width: deviceWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Icon(Icons.check,size: 160,color: Colors.white,),
                ),
              ),
              SizedBox(height: 20,),
              Text('Thank You!',style: TextStyleUtils.primaryTextBold.copyWith(fontSize: fontSize27),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text('The registration successful',style: TextStyleUtils.primaryTextMedium.copyWith(fontSize: fontSize20),textAlign: TextAlign.center,),
              Container(
                width: deviceWidth(context),
                margin: EdgeInsets.only(left: 30,right: 30,top: 70,bottom: 10),
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        HomePage()), (Route<dynamic> route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(margin20),
                    ),
                    elevation: margin2,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      Constant.continueString,
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
