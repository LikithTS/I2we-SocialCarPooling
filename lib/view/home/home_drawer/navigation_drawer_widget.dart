import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_page.dart';

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
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: 'My Rides',
                icon: Icons.directions_car,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text: 'History',
                icon: Icons.history,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text: 'My Vechicle',
                icon: Icons.car_crash_sharp,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text: 'My Questionaries',
                icon: Icons.help,
                onClicked: () => selectedItem(context, 3)),
            buildMenuItem(
                text: 'Rating & Reviews',
                icon: Icons.stars,
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                text: 'Feedback',
                icon: Icons.forum,
                onClicked: () => selectedItem(context, 5)),
            buildMenuItem(
                text: 'Subscription',
                icon: Icons.subscriptions,
                onClicked: () => selectedItem(context, 6)),
            buildMenuItem(
                text: 'Terms & Conditions',
                icon: Icons.description,
                onClicked: () => selectedItem(context, 7)),
            buildMenuItem(
                text: 'Privacy Policy',
                icon: Icons.screen_lock_portrait,
                onClicked: () => selectedItem(context, 8)),
            buildMenuItem(
                text: 'Help',
                icon: Icons.help,
                onClicked: () => selectedItem(context, 9)),
            buildMenuItem(
                text: 'About us',
                icon: Icons.info,
                onClicked: () => selectedItem(context, 10)),
            buildMenuItem(
                text: 'Logout',
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
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        break;
    }
  }
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
