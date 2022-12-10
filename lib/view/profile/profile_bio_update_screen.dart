import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/network/response/user/UserProfileData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/utils/Localization.dart';

import '../../util/color.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../utils/widget_functions.dart';

class ProfileBioUpdateScreen extends StatefulWidget {
  const ProfileBioUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileBioUpdateScreen> createState() => _ProfileBioUpdateScreenState();
}

class _ProfileBioUpdateScreenState extends State<ProfileBioUpdateScreen> {
  TextEditingController bioController = TextEditingController();

  TextEditingController languageController = TextEditingController();

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
                          radius: 18,
                          backgroundColor: primaryLightColor,
                          child: Icon(
                            Icons.photo_camera,
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 20, bottom: 10),
                  child: Material(
                    elevation: 2.0,
                    child: TextFormField(
                      controller: languageController,
                      readOnly: true,
                      showCursor: true,
                      cursorWidth: 0,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: DemoLocalizations.of(context)
                                ?.getText("languages_known") ??
                            "",
                        hintText: "Kannada,Hindi",
                        labelStyle: const TextStyle(color: hintColor),
                        hintStyle: const TextStyle(color: primaryLightColor),
                        prefixIcon: const Icon(Icons.newspaper,
                            color: primaryLightColor),
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: primaryLightColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 12,
                          color: hintColor,
                        ),
                        profileBioText(
                            DemoLocalizations.of(context)
                                    ?.getText("bio_char_limit") ??
                                "",
                            12.sp,
                            hintColor)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 5, bottom: 10),
                  child: Material(
                    elevation: 2.0,
                    child: TextFormField(
                      controller: bioController,
                      showCursor: true,
                      maxLines: 5,
                      cursorWidth: 0,
                      decoration: InputDecoration(
                        filled: true,
                        labelText:
                            DemoLocalizations.of(context)?.getText("bio") ?? "",
                        hintText: "",
                        labelStyle: const TextStyle(color: hintColor),
                        hintStyle: const TextStyle(color: primaryLightColor),
                        prefix: const Icon(Icons.emoji_emotions,
                            color: primaryLightColor),
                        suffix: const Icon(
                          Icons.done,
                          color: primaryLightColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      updateBio();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(margin20),
                      ),
                      elevation: margin2,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        DemoLocalizations.of(context)?.getText("save") ?? "",
                        style: TextStyle(fontSize: fontSize18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateBio() {
    if (bioController.text.isEmpty) {
      return;
    }

    updateUserApi(
        UserProfileData(bio: bioController.text, language: ['ENGLISH']));
  }

  void updateUserApi(UserProfileData updaterUserApi) {
    Future<dynamic> future =
        UpdateUserRepository().updateUserDetails(api: updaterUserApi);
    future.then((value) => {handleResponseData(value)});
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
      print("UPdate success" + value.toString());
      //print("Response Data : ${value.statusCode}");
    } else {
      print("UPdate failure " + value.toString());
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
Widget profileBioText(String title, double fontSize, Color color) => Container(
    margin: EdgeInsets.symmetric(horizontal: 8.w),
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
