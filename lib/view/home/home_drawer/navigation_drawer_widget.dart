import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/repository/LoginRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/questionarie/questionarie_view.dart';

import '../../../util/CPSessionManager.dart';
import '../../login/login_screen.dart';

import '../../../utils/Localization.dart';
import '../../myvehicle/my_vehicle_start_page.dart';

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
                onClicked: () => {}),
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
                text: DemoLocalizations.of(context)
                        ?.getText("my_questionaries") ??
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

  Widget buildMenuItem({required String text,
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
            context, MaterialPageRoute(builder: (context) => HomePage(homeRepository: HomeRepository())));
        break;
      case 3:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyVehicleStartPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const QuestionariePage()));
        break;
      case 11:
        onLogoutButtonPressed(context);
        break;
    }
  }

  void onLogoutButtonPressed(BuildContext context) {
    LoginRepository()
        .logout()
        .then((value) => {
          handleResponseData(value, context)
  }
    );
  }

  handleResponseData(value, BuildContext context) {
    if (value is SuccessResponse) {
      CPSessionManager().handleUserLogout();
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) =>
              LoginScreen(userRepository: LoginRepository())));
    }
  }
}

Widget buildHeader({required String profile_percentage,
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
