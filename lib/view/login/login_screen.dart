import 'dart:developer';

import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/request/loginapi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPSessionManager.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/login/login_text_form.dart';
import 'package:socialcarpooling/view/sign_up/sign_up_page.dart';

import '../../util/color.dart';
import '../../util/margin_confiq.dart';
import '../../utils/Localization.dart';

class LoginScreen extends StatefulWidget {
  final LoginRepository userRepository;

  const LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController =
        TextEditingController(text: "9986215749");
    TextEditingController passwordController =
        TextEditingController(text: "Test@1234");

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
                  Image.asset("assets/images/facebook_icon.png",
                      width: 45.w, height: 45.h, fit: BoxFit.fill),
                  addHorizontalSpace(20),
                  Image.asset("assets/images/google_icon.png",
                      width: 45.w, height: 45.h, fit: BoxFit.fill)
                ],
              ),
              addHorizontalSpace(20),
              smallText("or", Alignment.center),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    LoginTextForm(
                      editingController: phoneNumberController,
                      hint: DemoLocalizations.of(context)
                              ?.getText("mobile_number") ??
                          "",
                      lableText: DemoLocalizations.of(context)
                              ?.getText("mobile_number") ??
                          "",
                      formValidator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return "Mobile Number Cannot be Empty";
                        }
                        return null;
                      },
                      suffixIcon: Icons.check_circle,
                      prefixIcon: Icons.mobile_friendly,
                    ),
                    addVerticalSpace(10),
                    LoginTextForm(
                      editingController: passwordController,
                      formValidator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return "Password Cannot be Empty";
                        }
                        return null;
                      },
                      lableText:
                          DemoLocalizations.of(context)?.getText("password") ??
                              "",
                      hint:
                          DemoLocalizations.of(context)?.getText("password") ??
                              "",
                      suffixIcon: Icons.visibility,
                      prefixIcon: Icons.lock,
                    )
                  ],
                ),
              ),
              smallText(
                  DemoLocalizations.of(context)?.getText("forgot_password") ??
                      "",
                  Alignment.topRight),
              Center(
                child: SizedBox(
                    height: 60,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: _buildButton("Login", () {
                        login(phoneNumberController.text,
                            passwordController.text);
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
                          child: SignUpPage()));
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
                         // print("Register now" "pressed");
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
              Center(
                  child: RichText(
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
              )),
              addVerticalSpace(20)
            ],
          ),
        ),
      ),
    );
  }

  void login(String phoneNumber, String password) {
    log("login Data: $phoneNumber");
    LoginApi api = LoginApi(phoneNumber: phoneNumber, password: password);
    Future<dynamic> future = _userRepository.login(api: api);
    future.then((value) => {handleResponseData(value)});
    //     .catchError((onError) {
    //   handleErrorResponse(onError);
    // });
  }

  handleResponseData(value) {
    if (value is AuthResponse) {
      CPSessionManager().setAuthToken(value.accessToken ?? "");
      CPSessionManager().setAuthRefreshToken(value.refreshToken ?? "");

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.bottomToTop,
              child: HomePage(homeRepository: HomeRepository())));
    } else {
      // ErrorResponse errorResponse = value;
      // setState(() {
      //   errorText = errorResponse.errorMessage.toString();
      // });
    }
  }

  handleErrorResponse(value) {}

  Widget _buildButton(String title, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(margin10)),
        ), // <-- Radius
        primary: title == 'Skip' ? Colors.white : primaryLightColor,
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
}
