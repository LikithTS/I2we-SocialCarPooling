import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/view/profile/verification/aadhar/AadharVerfication.dart';
import 'package:socialcarpooling/view/profile/verification/drivinglicense/DrivingLicenseScreen.dart';

import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';

class VerificationMainScreen extends StatefulWidget {
  const VerificationMainScreen({Key? key}) : super(key: key);

  @override
  State<VerificationMainScreen> createState() => _VerificationMainScreenState();
}

class _VerificationMainScreenState extends State<VerificationMainScreen> {
  File? _profileImage;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      DemoLocalizations.of(context)?.getText("verification") ??
                          "")
                ],
              ),
              addVerticalSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: verificatonScreenText(
                    DemoLocalizations.of(context)
                            ?.getText("verify_personal_identity") ??
                        "",
                    primaryColor,
                    14.sp,
                    FontWeight.normal,
                    Alignment.topLeft),
              ),
              addVerticalSpace(10),
              verificationCard(
                  DemoLocalizations.of(context)
                          ?.getText("aadhar_verification") ??
                      "", () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: const AadharVerificationScreen()));
              }),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: verificatonScreenText(
                    DemoLocalizations.of(context)
                            ?.getText("add_driving_license") ??
                        "",
                    primaryColor,
                    14.sp,
                    FontWeight.normal,
                    Alignment.topLeft),
              ),
              addVerticalSpace(10),
              verificationCard(
                  DemoLocalizations.of(context)
                          ?.getText("driving_verification") ??
                      "", () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: const DrivingLicenseScreen()));
              }),
            ],
          ),
        ),
      ),
    ));
  }

  Future getImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    File image = File(pickedFile!.path);
    CroppedFile? cropFile =
        await ImageCropper().cropImage(sourcePath: image.path);
    setState(() {
      _profileImage = image;
      print("_profileImage${cropFile!.path}");
    });
  }
}

Widget verificationCard(String title, VoidCallback onTap) => Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verificatonScreenText(title, Colors.black, 14.sp,
                    FontWeight.normal, Alignment.topLeft),
                const Icon(
                  Icons.navigate_next,
                  color: primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );

Widget verificatonScreenText(String? title, Color color, double size,
        FontWeight fontWeight, Alignment alignment) =>
    Container(
      child: Align(
        alignment: alignment,
        child: Text(title!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: size,
                decoration: TextDecoration.none,
                color: color,
                fontWeight: fontWeight,
                fontFamily: 'Poppins')),
      ),
    );
