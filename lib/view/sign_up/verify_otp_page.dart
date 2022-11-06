import 'dart:async';
import 'dart:developer';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/SigninRepository.dart';
import 'package:common/network/request/SendOtpApi.dart';
import 'package:common/network/request/ValidOtpApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/sign_up/verifyed_page.dart';
import 'package:socialcarpooling/widgets/header_widgets.dart';

import '../../util/CPSessionManager.dart';
import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../widgets/edit_text_widgets.dart';
import '../../widgets/image_widgets.dart';

class VerifyOtpPage extends StatefulWidget {
  final String userName;
  final String mobileNo;

  const VerifyOtpPage({Key? key, required this.mobileNo, required this.userName}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage>
    with InputValidationMixin {
  TextEditingController mobileNoController = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;

  TextEditingController otpString1Controller =TextEditingController();
  TextEditingController otpString2Controller =TextEditingController();
  TextEditingController otpString3Controller =TextEditingController();
  TextEditingController otpString4Controller =TextEditingController();
  TextEditingController otpString5Controller =TextEditingController();
  TextEditingController otpString6Controller =TextEditingController();

  @override
  void initState() {
    super.initState();
    mobileNoController.text = widget.mobileNo;
    SendOtpApi sendOtpApi = SendOtpApi(phoneNumber: widget.mobileNo);
    sendOtp(sendOtpApi);
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

  void sendOtp(SendOtpApi sendOtpApi) {
    Future<dynamic> future = SigninRepository().sendOtp(api: sendOtpApi);
    future.then((value) => {handleResponseData(value)});
    //     .catchError((onError) {
    //   handleErrorResponse(onError);
    // });
  }

  void validOtp(ValidOtpApi validOtpApi) {
    Future<dynamic> future = SigninRepository().validOtp(api: validOtpApi);
    future.then((value) => {handleValidOtpResponseData(value)});
    //     .catchError((onError) {
    //   handleErrorResponse(onError);
    // });
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
     // print("Success ${value.statusCode}");

    } else {
      ErrorResponse errorResponse = value;
      print('Error ${errorResponse.errorMessage}');
    }
  }

  handleValidOtpResponseData(value) {
    if (value is SuccessResponse) {
      print("Success ${value.statusCode}");
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: VerifiedPage()));

    } else {
      ErrorResponse errorResponse = value;
      print('Error ${errorResponse.errorMessage}');
    }
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
                    style:
                        TextStyleUtils.primaryTextMedium.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  imageAssets(StringUrl.verifyPinImage, 200, 200),
                  const SizedBox(
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
                            Icons.mobile_screen_share_outlined,
                            4,
                            10,
                            this,
                            widget.mobileNo),
                      ),
                      Positioned(
                          right: 40,
                          bottom: 15,
                          child: Text(
                            'Edit',
                            style: TextStyleUtils.primaryTextMedium.copyWith(
                                color: primaryColor, fontSize: fontSize16),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        otpCard(otpString1Controller),
                        otpCard(otpString2Controller),
                        otpCard(otpString3Controller),
                        otpCard(otpString4Controller),
                        otpCard(otpString5Controller),
                        otpCard(otpString6Controller),

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
                  secondsRemaining != 0
                      ? RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          maxLines: 1,
                          textScaleFactor: 1,
                          text: TextSpan(
                            text: CPString.resendOtpIn,
                            style: TextStyleUtils.primaryTextRegular.copyWith(
                              color: borderColor,
                              fontSize: fontSize14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '00:${secondsRemaining.toString().padLeft(2, '0')} Sec',
                                style:
                                    TextStyleUtils.primaryTextSemiBold.copyWith(
                                  color: primaryColor,
                                  fontSize: fontSize16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: enableResend ? _resendCode : null,
                          child: RichText(
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                            softWrap: true,
                            maxLines: 1,
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: CPString.dontreciveOtp,
                              style: TextStyleUtils.primaryTextRegular.copyWith(
                                color: borderColor,
                                fontSize: fontSize14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: CPString.resendOTP,
                                  style: TextStyleUtils.primaryTextSemiBold
                                      .copyWith(
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
                    padding: EdgeInsets.symmetric(horizontal: margin20),
                    margin: EdgeInsets.only(top: margin20),
                    child: ElevatedButton(
                      onPressed: () {
                        CPSessionManager().setUserName(widget.userName);

                      /*  Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: VerifiedPage()));*/
                        var otpText=otpString1Controller.text.toString()+otpString2Controller.text.toString()+otpString3Controller.text.toString()+otpString4Controller.text.toString()+otpString5Controller.text.toString()+otpString6Controller.text.toString();
                        log("OTP Text: $otpText");
                        ValidOtpApi validOtpApi = ValidOtpApi(phoneNumber: mobileNoController.text.toString(), otp: otpText);
                        validOtp(validOtpApi);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(margin20),
                        ),
                        elevation: margin2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(margin20),
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
              margin: EdgeInsets.only(bottom: margin10),
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
                    text: CPString.signupAgree,
                    style: TextStyleUtils.primaryTextRegular.copyWith(
                      color: borderColor,
                      fontSize: fontSize14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: CPString.termsConditions,
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
  Widget otpCard(TextEditingController controller) =>  Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    elevation: 2,
    shadowColor: borderColor,
    child: Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 48,
        width: 48,
        child: TextFormField(
          controller: controller,
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
          onSaved: (pin) {
          },
        ),
      ),
    ),
  );


  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 10;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}
