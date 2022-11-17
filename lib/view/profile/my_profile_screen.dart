import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:socialcarpooling/utils/Localization.dart';
import 'package:socialcarpooling/view/profile/profile_bio_update_screen.dart';
import 'package:socialcarpooling/view/profile/profile_update_screen.dart';

import '../../util/color.dart';
import '../../utils/widget_functions.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color lightOrange = Color(0Xfffacb9c);
    final Color orange = Color(0XffF29339);
    final Color lightBlue = Color(0Xffd9e9fc);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    headerText(
                        DemoLocalizations.of(context)?.getText("profile") ?? "")
                  ],
                ),
                addVerticalSpace(20),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 50,
                      ),
                      child: Image.asset(
                          "assets/images/profile_background_car.png",
                          width: size.width,
                          height: 200,
                          fit: BoxFit.cover),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 18,
                          ),
                          child: CircleAvatar(
                            radius: 58,
                            backgroundImage: NetworkImage(
                                "https://cdn.britannica.com/64/182864-050-8975B127/Scene-The-Incredible-Hulk-Louis-Leterrier.jpg"),
                          ),
                        ),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.photo_camera,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                addVerticalSpace(5),
                userNameText("User Name"),
                workText("Work, Designation"),
                addVerticalSpace(20),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  height: 120,
                  width: double.maxFinite,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                          child: Icon(
                            Icons.verified_user,
                            color: orange,
                            size: 40,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: profileText(
                                          DemoLocalizations.of(context)
                                                  ?.getText("get_verified") ??
                                              "",
                                          14.sp,
                                          Colors.black)),
                                  addHorizontalSpace(20),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: profileText(
                                          DemoLocalizations.of(context)
                                                  ?.getText("pending") ??
                                              "",
                                          14.sp,
                                          orange))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    28, 0.0, 8.0, 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      // add this
                                      child: Text(
                                        DemoLocalizations.of(context)?.getText(
                                                "profile_screen_verification_pending_desc") ??
                                            "",
                                        maxLines:
                                            3, // you can change it accordingly
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color:
                                                Color(0Xff707070)), // and this
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: ProfileUpdateScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        height: 180,
                        width: size.width / 2,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: lightBlue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: profileText(
                                            DemoLocalizations.of(context)
                                                    ?.getText(
                                                        "profile_completed") ??
                                                "",
                                            14.sp,
                                            const Color(0Xff707070)),
                                      ),
                                      addVerticalSpace(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          profileText(
                                              DemoLocalizations.of(context)
                                                      ?.getText(
                                                          "view_details") ??
                                                  "",
                                              14.sp,
                                              Colors.black),
                                          Icon(Icons.arrow_right)
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.white),
                              child: CircularPercentIndicator(
                                  radius: 60,
                                  lineWidth: 6,
                                  percent: 10 / 100,
                                  progressColor: primaryColor,
                                  backgroundColor: lightGreyColor,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: progressTextBlack(
                                      "10%", 13.sp, primaryColor)),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        height: 180,
                        width: size.width / 2,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: lightOrange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: profileText(
                                            DemoLocalizations.of(context)
                                                    ?.getText(
                                                        "verify_pending") ??
                                                "",
                                            14.sp,
                                            const Color(0Xff707070)),
                                      ),
                                      addVerticalSpace(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          profileText("View Details", 14.sp,
                                              Colors.black),
                                          Icon(Icons.arrow_right)
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.white),
                              child: CircularPercentIndicator(
                                  radius: 60,
                                  lineWidth: 6,
                                  percent: 10 / 100,
                                  progressColor: orange,
                                  backgroundColor: lightGreyColor,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center:
                                      progressTextBlack("10%", 13.sp, orange)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  height: 250,
                  width: double.maxFinite,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: ProfileBioUpdateScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                profileText(
                                    DemoLocalizations.of(context)
                                            ?.getText("bio") ??
                                        "",
                                    12.sp,
                                    primaryColor),
                                profileText(
                                    DemoLocalizations.of(context)
                                            ?.getText("edit") ??
                                        "",
                                    12.sp,
                                    orange),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: profileText(
                                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis",
                                  12.sp,
                                  const Color(0Xff707070)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0, bottom: 4.0),
                            child: Row(
                              children: [
                                profileText(
                                    DemoLocalizations.of(context)
                                            ?.getText("languages") ??
                                        "",
                                    12.sp,
                                    primaryColor),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Row(
                              children: [
                                profileText("Kannada, English", 12.sp,
                                    const Color(0Xff707070)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget userNameText(String title) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          style: TextStyle(
              fontSize: 32.sp,
              decoration: TextDecoration.none,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins')),
    ));

Widget workText(String title) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          style: TextStyle(
              fontSize: 20.sp,
              decoration: TextDecoration.none,
              color: const Color(0Xff242134),
              fontWeight: FontWeight.w200,
              fontFamily: 'Poppins')),
    ));

Widget progressTextBlack(String title, double fontSize, Color color) =>
    Container(
        child: Align(
      child: Text(title,
          softWrap: false,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              decoration: TextDecoration.none,
              color: color,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins')),
    ));
Widget profileText(String title, double fontSize, Color color) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          softWrap: false,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              decoration: TextDecoration.none,
              color: color,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins')),
    ));
