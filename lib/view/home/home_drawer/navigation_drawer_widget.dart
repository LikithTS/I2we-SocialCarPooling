import 'dart:io';

import 'package:common/network/exception/ApiException.dart';
import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:socialcarpooling/util/AppPreference.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/view/WebviewPage.dart';
import 'package:socialcarpooling/view/feedback/feedback_page.dart';
import 'package:socialcarpooling/view/history/history_page.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_screen.dart';
import 'package:socialcarpooling/view/myvehicle/all_car_details_screen.dart';
import 'package:socialcarpooling/view/myvehicle/my_vehicle_start_page.dart';
import 'package:socialcarpooling/view/questionarie/questionarie_view.dart';
import 'package:socialcarpooling/view/ratingsandreviews/ratings_reviews_screen.dart';
import 'package:socialcarpooling/view/subscription/subscription_page.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../../util/string_url.dart';
import '../../../util/Localization.dart';
import '../../../widgets/image_widgets.dart';
import '../../login/login_screen.dart';
import '../../profile/my_profile_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  var profileImage = "";

  @override
  Widget build(BuildContext context) {
    final name = AppPreference().userDetail?.name ?? "";
    final profile_percentage =
        "Profile ${AppPreference().userDetail?.percentageOfCompletion ?? 0}% Completed";
    final profileImage = CPSessionManager().getProfileImage();

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            buildHeader(
                name: name,
                profile_percentage: profile_percentage,
                profileImage: profileImage,
                onClicked: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfileScreen()))
                    }),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("my_rides") ?? "",
                icon: Icons.directions_car,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("history") ?? "",
                icon: Icons.history,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("my_vehicle") ?? "",
                icon: Icons.car_crash_sharp,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("my_questioners") ??
                        "",
                icon: Icons.help,
                onClicked: () => selectedItem(context, 3)),
            buildMenuItem(
                text: DemoLocalizations.of(context)
                        ?.getText("ratings_and_reviews") ??
                    "",
                icon: Icons.stars,
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("feedback") ?? "",
                icon: Icons.forum,
                onClicked: () => selectedItem(context, 5)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("subscription") ??
                    "",
                icon: Icons.subscriptions,
                onClicked: () => selectedItem(context, 6)),
            buildMenuItem(
                text: DemoLocalizations.of(context)
                        ?.getText("terms_and_conditions") ??
                    "",
                icon: Icons.description,
                onClicked: () => selectedItem(context, 7)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("privacy_policy") ??
                        "",
                icon: Icons.screen_lock_portrait,
                onClicked: () => selectedItem(context, 8)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("help") ?? "",
                icon: Icons.help,
                onClicked: () => selectedItem(context, 9)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("about_us") ?? "",
                icon: Icons.info,
                onClicked: () => selectedItem(context, 10)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("logout") ?? "",
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 11)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text,
      required IconData icon,
      required VoidCallback onClicked}) {
    const iconColor = primaryColor;
    return ListTile(
      visualDensity: const VisualDensity(vertical: -3),
      leading: BorderIcon(
        height: 30,
        width: 30,
        padding: EdgeInsets.zero,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: tileText(text, Alignment.topLeft, textAlign: TextAlign.start),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyRidesScreen()));
        break;

      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HistoryPage()));
        break;

      case 2:
        if (CPSessionManager().getIfCarDetailsAdded()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AllCarDetailsPage(carRepository: CarRepository())));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyVehicleStartPage()));
        }
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QuestionariePage()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RatingsAndReviews()));
        break;
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return const CustomDialog(
      //         title: "Allow Your Location",
      //         descriptions:
      //             "We need your location permission to Give better expericance",
      //         rightButtonText: "Allow",
      //         leftButtonText: "Not now",
      //         img: "assets/images/location_dialog.png",
      //       );
      //     });
      // break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedbackPage()));
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubscriptionPage()));
        break;
      case 7:
        if (Platform.isIOS) {
          launchWebViewScreen(
              context,
              DemoLocalizations.of(context)?.getText("terms_and_conditions") ??
                  "",
              Constant.TERMS_CONDITION_IOS_URL);
        } else {
          launchWebViewScreen(
              context,
              DemoLocalizations.of(context)?.getText("terms_and_conditions") ??
                  "",
              Constant.TERMS_CONDITION_ANDROID_URL);
        }
        break;
      case 8:
        launchWebViewScreen(
            context,
            DemoLocalizations.of(context)?.getText("privacy_policy") ?? "",
            Constant.PRIVACY_POLICY_URL);
        break;
      case 9:
        // launchWebViewScreen(
        //     context,
        //     DemoLocalizations.of(context)?.getText("help") ?? "",
        //     Constant.HELP_URL);
        showHelpDialog(context);
        break;
      case 10:
        launchWebViewScreen(
            context,
            DemoLocalizations.of(context)?.getText("about_us") ?? "",
            Constant.ABOUT_US_URL);
        break;
      case 11:
        showLogoutConfirmationDialog(context);
        break;
    }
  }

  void launchWebViewScreen(BuildContext context, String title, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(title: title, url: url)));
  }

  void onLogoutButtonPressed(BuildContext context) {
    LoginRepository()
        .logout()
        .then((value) => {handleResponseData(value, context)})
        .catchError((onError) {
      handleErrorResponseData(onError, context);
    });
  }

  void handleErrorResponseData(onError, BuildContext context) {
    if (onError is ApiException) {
      showSnackbar(
          homeGlobalkey.currentContext!, onError.errorResponse.message ?? "");
    }
  }

  handleResponseData(value, BuildContext context) {
    if (value is SuccessResponse) {
      CPSessionManager().handleUserLogout();
      Navigator.pushReplacement(
          homeGlobalkey.currentContext!,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(userRepository: LoginRepository())));
    }
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showAlertDialog(
        homeGlobalkey.currentContext!,
        CPString.Alert,
        CPString.logout_desc,
        CPString.no,
        CPString.yes,
        () => Navigator.pop(homeGlobalkey.currentContext!), () {
      Navigator.of(homeGlobalkey.currentContext!).pop(true);
      onLogoutButtonPressed(context);
    });
  }

  @override
  void initState() {
    super.initState();

    profileImage = CPSessionManager().getProfileImage();
  }
}

void showHelpDialog(BuildContext context) {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    showAboutDialog(
      context: context,
      applicationIcon: imageAssets(StringUrl.splashImage, 32.w, 32.h),
      applicationName: packageInfo.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese: CPString.copyright,
      children: <Widget>[
        // Text(DemoLocalizations.of(context)?.getText("help") ?? "",
        //     style: TextStyleUtils.primaryTextBold),
        const Padding(
            padding: EdgeInsets.only(top: 10), child: Text(CPString.help_desc))
      ],
    );
  });
}

Widget buildHeader(
        {required String profile_percentage,
        required String name,
        required String profileImage,
        required VoidCallback onClicked}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(children: [
            profileImage.isNotEmpty
                ? CircleAvatar(
                    radius: 30,
                    backgroundColor: lightGreyColor,
                    backgroundImage: NetworkImage(
                        CPSessionManager().getProfileImageWithBase()),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundColor: lightGreyColor,
                    backgroundImage: Image.file(File(CPSessionManager().getProfileImage())).image,
                  ),
            addHorizontalSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tileText(name, Alignment.topLeft, textAlign: TextAlign.start),
                tileText(profile_percentage, Alignment.topLeft,
                    textAlign: TextAlign.start,
                    textColor: greyColor,
                    fontSize: 9)
              ],
            )
          ])),
    );

Widget tileText(String text, Alignment alignment,
        {TextAlign? textAlign, Color? textColor, double? fontSize}) =>
    Container(
        child: Align(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
            fontSize: fontSize ?? 19.sp,
            height: 1.3,
            color: textColor ?? greyColor,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            fontFamily: 'Poppins'),
        maxLines: 1,
      ),
    ));
