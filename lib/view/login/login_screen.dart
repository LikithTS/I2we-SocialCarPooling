import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/login/login_text_form.dart';
import 'package:socialcarpooling/view/sign_up/sign_up_page.dart';

import '../../widgets/button_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(25),
                headerText("Keep Connected"),
                addVerticalSpace(6),
                smallText(
                    "A carpool is simple. It’s an arrangement between two or more people to make",
                    Alignment.topLeft),
                addVerticalSpace(25),
                Center(
                    child: Image.asset("assets/images/login_image.png",
                        width: 200.w, height: 200.h, fit: BoxFit.fill)),
                addVerticalSpace(20),
                smallText("Sign with social networks", Alignment.center),
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
                        hint: "Mobile Number",
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
                        formValidator: (value) {
                          if (value!.isEmpty || value.isEmpty) {
                            return "Password Cannot be Empty";
                          }
                          return null;
                        },
                        hint: "Password",
                        suffixIcon: Icons.visibility,
                        prefixIcon: Icons.lock,
                      )
                    ],
                  ),
                ),
                smallText("Forgot Password?", Alignment.topRight),
                Center(
                  child: SizedBox(
                      height: 60,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: primaryButtonWithCallBack("Login", login),
                      )),
                ),
                addVerticalSpace(10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: SignUpPage()));
                  },
                  child: smallText(
                      "Don’t have an account? Register Now", Alignment.center),
                ),
                addVerticalSpace(30),
                Center(
                  child: smallText(
                      "By signing up, you are agree with our Terms & Conditions",
                      Alignment.center,
                      TextAlign.center),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop, child: HomePage()));
  }
}
