import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/sign_up/verifyed_page.dart';
import 'package:socialcarpooling/widgets/header_widgets.dart';

import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../widgets/edit_text_widgets.dart';
import '../../widgets/image_widgets.dart';

class VerifyOtpPage extends StatefulWidget {
  final String mobileNo;
  const VerifyOtpPage({Key? key, required this.mobileNo}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> with InputValidationMixin {
  TextEditingController mobileNoController = TextEditingController();
  int secondsRemaining = 10;
  bool enableResend = false;
  Timer? timer;

  String resendOtp='Resend OTP in ';
  String dontreciveOtp='Didn’t receive.Click here to ';

  @override
  void initState() {
    super.initState();
    mobileNoController.text=widget.mobileNo;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  headerLayout(context, CPString.verifyOTP),
                 Text(
                        CPString.verifyOTPTitle,
                        style: TextStyleUtils.primaryTextMedium
                            .copyWith(fontSize: 14),
                      ),
                  SizedBox(
                    height: 50,
                  ),
                  imageAssets(StringUrl.verifyPinImage, 200, 200),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: inputEditTextWithPrefixWidget(
                            context,
                            CPString.mobileNo,
                            mobileNoController,
                            CPString.mobileError,
                            Icons.mobile_screen_share_outlined,4,this,widget.mobileNo),
                      ),
                      Positioned(
                          right: 40,
                          bottom: 15,
                          child: Text('Edit',style: TextStyleUtils.primaryTextMedium.copyWith(color: primaryColor,fontSize: fontSize16),))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 2,
                          shadowColor: borderColor,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 64,
                              width: 64,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin) {},
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 2,
                          shadowColor: borderColor,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 64,
                              width: 64,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin) {},
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 2,
                          shadowColor: borderColor,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 64,
                              width: 64,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin) {},
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 2,
                          shadowColor: borderColor,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 64,
                              width: 64,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                onSaved: (pin) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 /* ElevatedButton(
                    child: Text('Resend Code'),
                    onPressed: enableResend ? _resendCode : null,
                  ),*/
                  secondsRemaining!=0?  RichText(
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      maxLines: 1,
                      textScaleFactor: 1,
                      text: TextSpan(
                        text: resendOtp,
                        style: TextStyleUtils.primaryTextRegular.copyWith(
                          color: borderColor,
                          fontSize: fontSize14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '00:${secondsRemaining.toString().padLeft(2, '0')} Sec',
                            style: TextStyleUtils.primaryTextSemiBold.copyWith(
                              color: primaryColor,
                              fontSize: fontSize16,
                            ),
                          ),
                        ],
                      ),
                  ):InkWell(
                    onTap:enableResend ? _resendCode : null,
                    child:RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1,
                    text: TextSpan(
                      text: dontreciveOtp,
                      style: TextStyleUtils.primaryTextRegular.copyWith(
                        color: borderColor,
                        fontSize: fontSize14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyleUtils.primaryTextSemiBold.copyWith(
                            color: primaryColor,
                            fontSize: fontSize16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                  Container(
                    width: deviceWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        /* if (_formKey.currentState!.validate()) {
                              _registration(fullNameController.text);
                            }*/
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child:VerifiedPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(margin20),
                        ),
                        elevation: margin2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          CPString.verify,
                          style: TextStyle(fontSize: fontSize18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                    text: 'By Signing up ,you agree with our ',
                    style: TextStyleUtils.primaryTextRegular.copyWith(
                      color: borderColor,
                      fontSize: fontSize14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms & conditions',
                        style: TextStyleUtils.primaryTextSemiBold.copyWith(
                            color: primaryColor,
                            fontSize: fontSize16,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
  void _resendCode() {
    //other code here
    setState((){
      secondsRemaining = 10;
      enableResend = false;
    });
  }

  @override
  dispose(){
    timer?.cancel();
    super.dispose();
  }

}
