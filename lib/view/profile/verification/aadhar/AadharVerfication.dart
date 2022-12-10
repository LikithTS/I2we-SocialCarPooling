import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialcarpooling/view/profile/verification/aadhar/VerificationViewModel.dart';

import '../../../../util/color.dart';
import '../../../../util/font_size.dart';
import '../../../../util/margin_confiq.dart';
import '../../../../utils/Localization.dart';
import '../../../../utils/widget_functions.dart';

class AadharVerificationScreen extends StatefulWidget {
  const AadharVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AadharVerificationScreen> createState() =>
      _AadharVerificationScreenState();
}

class _AadharVerificationScreenState extends State<AadharVerificationScreen> {
  VerificationViewModel viewModel = VerificationViewModel();
  File? frontImageFile = null;
  File? backImageFile = null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    headerText(DemoLocalizations.of(context)
                            ?.getText("aadhar_verification") ??
                        "")
                  ],
                ),
                addVerticalSpace(20),
                displayFrontImage(),
                addVerticalSpace(20),
                displayBackImage(),
                addVerticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    //upload image
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
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget displayFrontImage() {
    if (frontImageFile == null) {
      return Column(
        children: [
          const Text("Aadhaar Front Image Not Selected"),
          ElevatedButton(
            onPressed: () {
              Future<dynamic> future = viewModel.getImage();
              future.then((value) => {
                    if (value != null && value is File)
                      setState(() {
                        frontImageFile = value;
                      })
                  });
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
                DemoLocalizations.of(context)?.getText("select") ?? "",
                style: TextStyle(fontSize: fontSize18),
              ),
            ),
          )
        ],
      );
    } else {
      return Image.file(frontImageFile!, width: 350, height: 350);
    }
  }

  Widget displayBackImage() {
    if (backImageFile == null) {
      return Column(
        children: [
          const Text("Aadhaar Back Image Not Selected"),
          ElevatedButton(
            onPressed: () {
              Future<dynamic> future = viewModel.getImage();
              future.then((value) => {
                    if (value != null && value is File)
                      setState(() {
                        backImageFile = value;
                      })
                  });
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
                DemoLocalizations.of(context)?.getText("select") ?? "",
                style: TextStyle(fontSize: fontSize18),
              ),
            ),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Image.file(backImageFile!, width: 350, height: 350),
        ],
      );
    }
  }
}
