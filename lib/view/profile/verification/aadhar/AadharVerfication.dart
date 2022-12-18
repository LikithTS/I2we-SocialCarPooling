import 'dart:io';

import 'package:common/network/response/user/IdentificationImageUpload.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/view/profile/verification/aadhar/VerificationViewModel.dart';

import '../../../../font&margin/margin_confiq.dart';
import '../../../../util/color.dart';
import '../../../../utils/Localization.dart';
import '../../../../utils/widget_functions.dart';
import '../../../commondialog/custom_dialog.dart';

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
  void initState() {
    super.initState();
  }

  handleData(List<IdentificationImageUpload> value) {
    setState(() {
      if (value != null) {
        value;
      }
    });
  }

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
                    uploadAadhar();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Future<dynamic> future = viewModel.getImage();
                future.then((value) => {
                      if (value != null && value is File)
                        setState(() {
                          frontImageFile = value;
                        })
                    });
              },
              child: Card(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Aadhaar Front Image Not Selected"),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Future<dynamic> future = viewModel.getImage();
                  future.then((value) => {
                        if (value != null && value is File)
                          setState(() {
                            frontImageFile = value;
                          })
                      });
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(frontImageFile!,
                          width: MediaQuery.of(context).size.width, height: 200)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget displayBackImage() {
    if (backImageFile == null) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Future<dynamic> future = viewModel.getImage();
                future.then((value) => {
                      if (value != null && value is File)
                        setState(() {
                          backImageFile = value;
                        })
                    });
              },
              child: Card(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Aadhaar Back Image Not Selected"),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Future<dynamic> future = viewModel.getImage();
                  future.then((value) => {
                        if (value != null && value is File)
                          setState(() {
                            backImageFile = value;
                          })
                      });
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(backImageFile!,
                          width: MediaQuery.of(context).size.width, height: 200)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  void uploadAadhar() {
    if (frontImageFile == null) {
      handleIfImageNotSelected("Image not selected",
          "Please select the front image of Aadhar for verification");
      return;
    }
    if (backImageFile == null) {
      handleIfImageNotSelected("Image not selected",
          "Please select the back image of Aadhar for verification");
      return;
    }

    var a = viewModel.getIdentificationUrl();
    a.then((value) => handleData(value));
  }

  void handleIfImageNotSelected(String title, String desc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: title,
            descriptions: desc,
            rightButtonText: "okay",
            leftButtonText: "Cancel",
            img: "assets/images/location_dialog.png",
          );
        });
  }
}
