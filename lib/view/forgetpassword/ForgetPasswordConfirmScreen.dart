import 'dart:async';
import 'dart:developer';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/ChangePasswordRespository.dart';
import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/request/ChangePasswordApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/profile/util/GetProfileDetails.dart';

import '../../util/CPString.dart';
import '../../util/InternetChecks.dart';
import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../util/configuration.dart';
import '../../font&margin/margin_confiq.dart';
import '../../util/string_url.dart';
import '../../util/Localization.dart';
import '../../widgets/aleart_widgets.dart';
import '../../widgets/edit_text_widgets.dart';
import '../../widgets/header_widgets.dart';
import '../../widgets/image_widgets.dart';

class ForgetPasswordConfirmScreen extends StatefulWidget {
  String mobileNumber;

  ForgetPasswordConfirmScreen({Key? key, required this.mobileNumber})
      : super(key: key);

  @override
  State<ForgetPasswordConfirmScreen> createState() =>
      _ForgetPasswordConfirmScreenState();
}

class _ForgetPasswordConfirmScreenState
    extends State<ForgetPasswordConfirmScreen> with InputValidationMixin {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  headerLayout(
                      context,
                      DemoLocalizations.of(context)!
                          .getText("forgot_password"), true),
                  const SizedBox(
                    height: 50,
                  ),
                  imageAssets(StringUrl.verifyPinImage, 200, 200),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: inputEditTextWithPrefixWidget(
                        context,
                        DemoLocalizations.of(context)!.getText("new_password"),
                        newPassController,
                        CPString.mobileError,
                        Icons.password,
                        4,
                        10,
                        this,
                        "",
                        false),
                  ),
                  addHorizontalSpace(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: inputEditTextWithPrefixWidget(
                        context,
                        DemoLocalizations.of(context)!
                            .getText("confirm_password"),
                        confirmPassController,
                        CPString.mobileError,
                        Icons.password,
                        4,
                        10,
                        this,
                        "",
                        false),
                  ),
                  Container(
                    width: deviceWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: margin20),
                    margin: EdgeInsets.only(top: margin20),
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        callChangePasswordApi(widget.mobileNumber);
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
                          DemoLocalizations.of(context)!
                              .getText("change_password"),
                          style: TextStyle(fontSize: fontSize18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void callChangePasswordApi(String mobileNumber) {
    log("New Password text ${newPassController.text}");
    log("Confirm Password text ${confirmPassController.text}");
    log("Mobile number $mobileNumber");
    if (newPassController.text == confirmPassController.text &&
        mobileNumber.isNotEmpty) {
      InternetChecks.showLoadingCircle(context);
      log("Both the password is same");
      ChangePasswordApi changePasswordApi = ChangePasswordApi(
          phoneNumber: mobileNumber, password: confirmPassController.text);
      Future<dynamic> future =
          ChangePasswordRepository().changePassword(api: changePasswordApi);
      future.then((value) => {handleResponseData(value)});
    }
  }

  handleResponseData(value) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      GetProfileDetails(context);
      Timer(
          const Duration(seconds: 2),
              () => Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: HomePage(homeRepository: HomeRepository()))));
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }
}
