import 'dart:async';
import 'dart:developer';

import 'package:common/model/GoogleUserObject.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/model/new_user_error_response.dart';
import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/repository/SigninRepository.dart';
import 'package:common/network/request/SendOtpApi.dart';
import 'package:common/network/request/SocialLoginApi.dart';
import 'package:common/network/request/loginapi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/FirebaseTokenUpdate.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/view/forgetpassword/forget_password_Screen.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/login/social_login_newUser_VerificationScreen.dart';
import 'package:socialcarpooling/view/profile/util/GetProfileDetails.dart';
import 'package:socialcarpooling/view/sign_up/sign_up_page.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../font&margin/margin_confiq.dart';
import '../../util/color.dart';
import '../../util/Localization.dart';
import '../sign_up/verify_otp_page.dart';
import 'authentication.dart';

class LoginScreen extends StatefulWidget {
  final LoginRepository userRepository;

  const LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginRepository get _userRepository => widget.userRepository;
  SigninRepository signInRepository = SigninRepository();
  TextEditingController phoneNumberController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _loginBloc.dispose();
    super.dispose();
  }

  void handlePasswordVisibleText() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(25),
              headerText(
                  DemoLocalizations.of(context)?.getText("Keep_Connected") ??
                      ""),
              addVerticalSpace(6),
              smallText(
                  DemoLocalizations.of(context)?.getText("login_desc_1") ?? "",
                  Alignment.topLeft),
              addVerticalSpace(25),
              Center(
                  child: Image.asset("assets/images/login_image.png",
                      width: 200.w, height: 200.h, fit: BoxFit.fill)),
              addVerticalSpace(20),
              smallText(
                  DemoLocalizations.of(context)
                          ?.getText("Sign_with_social_networks") ??
                      "",
                  Alignment.center),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: false,
                    child: Image.asset("assets/images/facebook_icon.png",
                        width: 45.w, height: 45.h, fit: BoxFit.fill),
                  ),
                  addHorizontalSpace(20),
                  InkWell(
                    onTap: () {
                      InternetChecks.isConnected().then((isAvailable) =>
                          {authenticateGoogleSingIn(isAvailable)});
                    },
                    child: Image.asset("assets/images/google_icon.png",
                        width: 45.w, height: 45.h, fit: BoxFit.fill),
                  )
                ],
              ),
              addHorizontalSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: smallText("or", Alignment.center),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                            color: greyColor,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ]),
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textAlign: TextAlign.start,
                    validator: (value) =>
                        value!.isEmpty ? 'Mobile Number Cannot be Empty' : null,
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                        fillColor: greyColor,
                        counterText: "",
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        hintText: DemoLocalizations.of(context)
                                ?.getText("mobile_number") ??
                            "",
                        hintStyle: const TextStyle(color: greyColor),
                        labelText: DemoLocalizations.of(context)
                                ?.getText("mobile_number") ??
                            "",
                        labelStyle: TextStyleUtils.hintTextStyle,
                        suffixIcon: IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.check_circle),
                          color: Colors.green,
                          onPressed: () {
                            // Do Nothing
                          },
                        ),
                        prefixIcon: const Icon(
                          Icons.mobile_friendly,
                          color: greyColor,
                        )),
                  ),
                ),
              ),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                            color: greyColor,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ]),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: passwordVisible,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    textAlign: TextAlign.start,
                    validator: (value) =>
                        value!.isEmpty ? 'Password Cannot be Empty' : null,
                    // onSaved: (value) => _email = value,
                    decoration: InputDecoration(
                        fillColor: greyColor,
                        counterText: "",
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        hintText: DemoLocalizations.of(context)
                                ?.getText("password") ??
                            "",
                        hintStyle: const TextStyle(color: greyColor),
                        labelText: DemoLocalizations.of(context)
                                ?.getText("password") ??
                            "",
                        labelStyle: TextStyleUtils.hintTextStyle,
                        suffixIcon: IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.visibility),
                          color: Colors.green,
                          onPressed: () {
                            handlePasswordVisibleText();
                          },
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: greyColor,
                        )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen()));
                },
                child: smallText(
                    DemoLocalizations.of(context)?.getText("forgot_password") ??
                        "",
                    Alignment.topRight),
              ),
              Center(
                child: SizedBox(
                    height: 60,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: _buildButton("Login", () {
                        InternetChecks.isConnected().then((isAvailable) => {
                              login(isAvailable, phoneNumberController.text,
                                  passwordController.text)
                            });
                      }),
                    )),
              ),
              addVerticalSpace(10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: const SignUpPage()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: smallText(
                          DemoLocalizations.of(context)
                                  ?.getText("register_now") ??
                              "",
                          Alignment.center),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: SignUpPage()));
                        },
                        child: Container(
                          child: smallSpanText(
                              DemoLocalizations.of(context)
                                      ?.getText("register_now_span") ??
                                  "",
                              Alignment.center,
                              TextAlign.start),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              addVerticalSpace(15),
              RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Container(
                      child: smallText(
                          DemoLocalizations.of(context)
                                  ?.getText("term_and_conditions") ??
                              "",
                          Alignment.center,
                          TextAlign.center),
                    ),
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        print("Terms & Conditions" "pressed");
                      },
                      child: Container(
                        child: smallSpanText(
                            DemoLocalizations.of(context)
                                    ?.getText("term_and_conditions_span") ??
                                "",
                            Alignment.center,
                            TextAlign.center),
                      ),
                    ),
                  )
                ]),
              ),
              addVerticalSpace(20)
            ],
          ),
        ),
      ),
    );
  }

  void login(bool isInternetAvailable, String phoneNumber, String password) {
    if (isInternetAvailable) {
      InternetChecks.showLoadingCircle(context);
      log("login Data: $phoneNumber");
      LoginApi api = LoginApi(phoneNumber: phoneNumber, password: password);
      Future<dynamic> future = _userRepository.login(api: api);
      future.then((value) => {handleResponseData(value, phoneNumber)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  handleResponseData(value, String phoneNumber) {
    log("Handle login response");
    if (value is AuthResponse) {
      handleSuccessResponse(value, phoneNumber);
    } else if (value is ErrorResponse) {
      log("Login Error response ${value.statusCode}");
      InternetChecks.closeLoadingProgress(context);
      if(value.statusCode == 406) {
        InternetChecks.isConnected()
            .then((isAvailable) => {
              callSendOtpApi(isAvailable, phoneNumber)
            });
      } else {
        showSnackbar(context, value.error?[0].message ?? value.message ?? "");
      }
    }
  }

  Widget _buildButton(String title, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin10)),
        ), // <-- Radius
        backgroundColor: title == 'Skip' ? Colors.white : primaryColor,
        textStyle: TextStyle(
            fontSize: 20.sp, fontFamily: 'assets/fonts/poppins_medium.ttf'),
        side: title == 'Skip'
            ? const BorderSide(width: 1.0, color: borderColor)
            : const BorderSide(width: 0, color: primaryLightColor),
      ),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
              color: title == 'Skip' ? borderColor : Colors.white,
              decoration: TextDecoration.none,
              fontFamily: 'assets/fonts/poppins_medium.ttf'),
        ),
      ),
    );
  }

  authenticateGoogleSingIn(bool isInternetAvailable) {
    if (isInternetAvailable) {
      InternetChecks.showLoadingCircle(context);
      AuthenticationHelper()
          .signInWithGoogle(context: context)
          .then((value) => {
                if (value is GoogleUserObject) {callSocialLoginApi(value)}
              });
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  callSocialLoginApi(GoogleUserObject userObject) {
    SocialLoginApi api = SocialLoginApi(
        name: userObject.displayName,
        email: userObject.email,
        phoneNumber: userObject.phoneNumber,
        token: userObject.accessToken.toString(),
        socialId: userObject.token.toString());
    Future<dynamic> future = _userRepository.socialLogin(api: api);
    future.then((value) => {handleSocialResponseData(value, userObject)});
  }

  handleSocialResponseData(value, GoogleUserObject userObject) {
    log("Response value $value");
    if (value is AuthResponse) {
      handleSuccessResponse(value, userObject.phoneNumber);
    } else if (value is NewUserErrorResponse) {
      if (value.statusCode == 503) {
        log("Navigate to mobile number page");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SocialLoginNewUserVerificationScreen(
                      googleUserObject: userObject,
                    )));
      }
    }
  }

  handleSuccessResponse(AuthResponse value, String? phoneNumber) {
    if (phoneNumber != null) {
      CPSessionManager().setUserId(phoneNumber);
    }
    CPSessionManager().setAuthToken(value.accessToken ?? "");
    CPSessionManager().setAuthRefreshToken(value.refreshToken ?? "");
    FirebaseTokenUpdate firebaseTokenUpdate = FirebaseTokenUpdate();
    firebaseTokenUpdate.getToken();
    firebaseTokenUpdate.initInfo();
    GetProfileDetails(context);
    Timer(
        const Duration(seconds: 2),
        () => {
              InternetChecks.closeLoadingProgress(context),
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: HomePage(homeRepository: HomeRepository())))
            });
  }

  void sendOtp(SendOtpApi sendOtpApi) {
    Future<dynamic> future = signInRepository.sendOtp(api: sendOtpApi);
    future.then((value) => {handleOtpResponseData(value, sendOtpApi.phoneNumber)});
  }

  void callSendOtpApi(bool isInternetAvailable, String mobileNo) {
    if (isInternetAvailable) {
      if (mobileNo.isNotEmpty) {
        InternetChecks.showLoadingCircle(context);
        SendOtpApi sendOtpApi = SendOtpApi(phoneNumber: mobileNo);
        sendOtp(sendOtpApi);
      }
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  handleOtpResponseData(value, String phoneNumber) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: VerifyOtpPage(
                userName: "User",
                mobileNo: phoneNumber,
              )));
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }

}
