import 'dart:io';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/network/response/user/ProfileImageUpdate.dart';
import 'package:common/network/response/user/ProfileImageUploadUrl.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:socialcarpooling/imageupload/AwsApi.dart';
import 'package:socialcarpooling/util/Localization.dart';
import 'package:socialcarpooling/view/profile/ProfileViewModel.dart';
import 'package:socialcarpooling/view/profile/profile_bio_update_screen.dart';
import 'package:socialcarpooling/view/profile/profile_update_screen.dart';
import 'package:socialcarpooling/view/profile/util/GetProfileDetails.dart';
import 'package:socialcarpooling/view/profile/verification/VerificationMainScreen.dart';

import '../../util/AppPreference.dart';
import '../../util/InternetChecks.dart';
import '../../util/color.dart';
import '../../widgets/widget_text.dart';
import '../../widgets/aleart_widgets.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  var viewmodel = ProfileViewModel();
  var profileImage = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        body:SingleChildScrollView(
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
                      icon: const Icon(Icons.arrow_back)),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 18,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              InternetChecks.isConnected().then(
                                      (isAvailable) =>
                                  {handleProfileUpload(isAvailable)});
                            });
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: lightGreyColor,
                            backgroundImage: NetworkImage(profileImage),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 20,
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
              userNameText(AppPreference().userDetail?.name ?? ""),
              workText(AppPreference().userDetail?.designation ?? ""),
              addVerticalSpace(10),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                height: 140,
                width: double.maxFinite,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                        EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                        child: Icon(
                          Icons.verified_user,
                          color: primaryColor,
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
                                        greyColor)),
                                addHorizontalSpace(20),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: profileText(
                                        DemoLocalizations.of(context)
                                            ?.getText("pending") ??
                                            "",
                                        14.sp,
                                        primaryColor))
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
                                      5, // you can change it accordingly
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: greyColor), // and this
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
                              child: const ProfileUpdateScreen()));
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
                              decoration: const BoxDecoration(
                                  color: lightBlueColor,
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
                                    Wrap(
                                      crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                      children: [
                                        Text(
                                          DemoLocalizations.of(context)
                                              ?.getText("view_details") ??
                                              "",
                                          style: const TextStyle(
                                            color: greyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const Icon(Icons.arrow_right)
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
                                percent: (AppPreference()
                                    .userDetail
                                    ?.percentageOfCompletion ??
                                    0) /
                                    100,
                                progressColor: primaryColor,
                                backgroundColor: lightGreyColor,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: progressTextBlack(
                                    (AppPreference()
                                        .userDetail
                                        ?.percentageOfCompletion ??
                                        0)
                                        .toString(),
                                    13.sp,
                                    primaryColor)),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: VerificationMainScreen()));
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
                              decoration: const BoxDecoration(
                                  color: primaryLightColor,
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
                                    Wrap(
                                      crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                      children: [
                                        Text(
                                          DemoLocalizations.of(context)
                                              ?.getText("view_details") ??
                                              "",
                                          style: const TextStyle(
                                            color: greyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        const Icon(Icons.arrow_right)
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
                                center:
                                progressTextBlack("10%", 13.sp, primaryColor)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                  primaryColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: profileText(
                                AppPreference().userDetail?.bio ?? "",
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
                              profileText(
                                  AppPreference()
                                      .userDetail
                                      ?.language
                                      ?.join(', ') ??
                                      "",
                                  12.sp,
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
    );
  }

  @override
  void initState() {
    super.initState();
    if (CPSessionManager().isUserLoggedIn()) {
      GetProfileDetails(context);
      profileImage = CPSessionManager().getProfileImageWithBase();
    }
  }

  void handleProfileUpload(bool isAvailable) {
    if (isAvailable) {
      InternetChecks.showLoadingCircle(context);
      Future<dynamic> future = viewmodel.getUserProfileUrl();
      future.then((value) => {handleprofileImageResponseData(value)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  void handleprofileImageResponseData(profileUrl) {
    if (profileUrl is ProfileImageUpload) {
      if (profileUrl.url != null && profileUrl.key != null) {
        InternetChecks.closeLoadingProgress(context);
        var uploadUrl = profileUrl.url!;
        AppPreference().profileImageKey = profileUrl.key ?? "";
        Future<dynamic> future = viewmodel.getProfileImage();
        future.then((value) => {
              if (value != null && value is File && uploadUrl.isNotEmpty)
                {handleImageUpload(value, uploadUrl, profileUrl)}
            });
      }
    }
  }

  handleImageUpload(
      File value, String uploadUrl, ProfileImageUpload profileUrl) async {
    InternetChecks.showLoadingCircle(context);
    CPSessionManager().setProfileImage(value.path);
    var isUploaded = await AwsApi().uploadImage(uploadUrl, value);
    if (isUploaded) {
      InternetChecks.closeLoadingProgress(context);
      updateUserApi(ProfileImageUpdate(profileImage: profileUrl.key), context,
          profileUrl.key);
    } else {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, "Something went wrong..Please try after sometime");
    }
  }

  void updateUserApi(ProfileImageUpdate profileImage, BuildContext context,
      String? key) async {
    Future<dynamic> future =
        UpdateUserRepository().updateProfilePhoto(api: profileImage);
    future.then((value) => {handleResponseData(value, context, key)});
  }

  void handleResponseData(value, BuildContext context, String? imageKey) {
    if (value is SuccessResponse) {
      InternetChecks.closeLoadingProgress(context);
      print("UPdate success$value");
      setState(() {
        if (imageKey != null) {
          profileImage = CPSessionManager().getProfileImageWithBase();
        }
      });

      //print("Response Data : ${value.statusCode}");
    } else if (value is ErrorResponse) {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
      print("UPdate failure $value");
      // ErrorResponse errorResponse = value;
      // setState(() {
      //   errorText = errorResponse.errorMessage.toString();
      // });
      //  print("Response Data : Error");

    }
  }
}

Widget userNameText(String title) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Align(
      child: Text(title,
          style: TextStyle(
              fontSize: 32.sp,
              decoration: TextDecoration.none,
              color: greyColor,
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
