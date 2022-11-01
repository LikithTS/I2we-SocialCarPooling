import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/WebviewPage.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_screen.dart';
import 'package:socialcarpooling/view/myvehicle/all_car_details_screen.dart';
import 'package:socialcarpooling/view/myvehicle/my_vehicle_start_page.dart';
import 'package:socialcarpooling/view/questionarie/questionarie_view.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../../util/CPSessionManager.dart';
import '../../../util/string_url.dart';
import '../../../utils/Localization.dart';
import '../../../widgets/image_widgets.dart';
import '../../login/login_screen.dart';
import '../../profile/my_profile_screen.dart';
import '../../ratingsandreviews/ratings_reviews_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = "Ram Prasad Reddy";
    final profile_percentage = "Profile 30% Completed";
    final profileImage =
        "https://free4kwallpapers.com/uploads/wallpaper/incredible-hulk-wallpaper-1024x768-wallpaper.jpg";

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
                text: DemoLocalizations.of(context)?.getText("home") ?? "",
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("my_rides") ?? "",
                icon: Icons.directions_car,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("history") ?? "",
                icon: Icons.history,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("my_vehicle") ?? "",
                icon: Icons.car_crash_sharp,
                onClicked: () => selectedItem(context, 3)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("my_questioners") ??
                        "",
                icon: Icons.help,
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                text: DemoLocalizations.of(context)
                        ?.getText("ratings_and_reviews") ??
                    "",
                icon: Icons.stars,
                onClicked: () => selectedItem(context, 5)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("feedback") ?? "",
                icon: Icons.forum,
                onClicked: () => selectedItem(context, 6)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("subscription") ??
                    "",
                icon: Icons.subscriptions,
                onClicked: () => selectedItem(context, 7)),
            buildMenuItem(
                text: DemoLocalizations.of(context)
                        ?.getText("terms_and_conditions") ??
                    "",
                icon: Icons.description,
                onClicked: () => selectedItem(context, 8)),
            buildMenuItem(
                text:
                    DemoLocalizations.of(context)?.getText("privacy_policy") ??
                        "",
                icon: Icons.screen_lock_portrait,
                onClicked: () => selectedItem(context, 9)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("help") ?? "",
                icon: Icons.help,
                onClicked: () => selectedItem(context, 10)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("about_us") ?? "",
                icon: Icons.info,
                onClicked: () => selectedItem(context, 11)),
            buildMenuItem(
                text: DemoLocalizations.of(context)?.getText("logout") ?? "",
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 12)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text,
      required IconData icon,
      required VoidCallback onClicked}) {
    const iconColor = Colors.blue;
    return ListTile(
      visualDensity: VisualDensity(vertical: -3),
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(homeRepository: HomeRepository())));
        break;

      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyRidesScreen()));
        break;

      case 3:
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
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QuestionariePage()));
        break;
      case 8:
        launchWebViewScreen(context, DemoLocalizations.of(context)?.getText("terms_and_conditions") ?? "", Constant.TERMS_CONDITION_URL);
        break;
      case 9:
        launchWebViewScreen(context, DemoLocalizations.of(context)?.getText("privacy_policy") ?? "", Constant.PRIVACY_POLICY_URL);
        break;
      case 10:
        launchWebViewScreen(context, DemoLocalizations.of(context)?.getText("help") ?? "", Constant.HELP_URL);
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RatingsAndReviews()));
        break;
      case 11:
        showAbout(context);
        break;
      case 12:
        showLogoutConfirmationDialog(context);
        break;
    }
  }

  void launchWebViewScreen(BuildContext context, String title, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(title: title, url: url)));
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
    if(onError is ErrorResponse) {
      showSnackbar(context, onError.errorMessage ?? "");
    }
  }

  handleResponseData(value, BuildContext context) {
    if (value is SuccessResponse) {
      CPSessionManager().handleUserLogout();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(userRepository: LoginRepository())));
    }
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showAlertDialog(homeGlobalkey.currentContext!, CPString.Alert, CPString.logout_desc, CPString.no, CPString.yes, () => Navigator.pop(homeGlobalkey.currentContext!)
    , () {
      Navigator.of(homeGlobalkey.currentContext!).pop(true);
      onLogoutButtonPressed(context);
    });
  }
}

void showAbout(BuildContext context) {
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    showAboutDialog(
      context: context,
      applicationIcon: imageAssets(
          StringUrl.splashImage, 32.w, 32.h),
      applicationName: packageInfo.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese: CPString.copyright,
      children: <Widget>[
        Text(DemoLocalizations.of(context)?.getText("about_us") ?? "", style: TextStyleUtils.primaryTextBold),
        const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(CPString.about_desc)
        )
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
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(profileImage)),
            addHorizontalSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tileText(name, Alignment.topLeft, textAlign: TextAlign.start),
                tileText(profile_percentage, Alignment.topLeft,
                    textAlign: TextAlign.start,
                    textColor: Colors.grey,
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
      child: Expanded(
        child: Text(
          text,
          textAlign: textAlign ?? TextAlign.start,
          style: TextStyle(
              fontSize: fontSize ?? 19.sp,
              height: 1.3,
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins'),
          maxLines: 1,
        ),
      ),
    ));
