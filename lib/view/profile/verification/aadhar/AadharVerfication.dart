import 'dart:io';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/network/response/user/AadharIdentificationUpdate.dart';
import 'package:common/network/response/user/IdentificationImageUpload.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/view/profile/verification/aadhar/VerificationViewModel.dart';

import '../../../../font&margin/margin_confiq.dart';
import '../../../../imageupload/AwsApi.dart';
import '../../../../util/InternetChecks.dart';
import '../../../../util/color.dart';
import '../../../../util/Localization.dart';
import '../../../../widgets/widget_text.dart';
import '../../../../widgets/aleart_widgets.dart';
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

  String? frontKey = "";
  String? backKey = "";

  @override
  void initState() {
    super.initState();
  }

  handleData(value) async {
    if (value is IdentificationImageUpload) {
      // handle front image upload
      var frontImage = await handleFrontImageUpload(value.frontVerificationUrl);
      var backImageUpload =
          await handleBackImageUpload(value.backVerificationUrl);
      if (backImageUpload && frontImage) {
        updateUserApi(AadharIdentificationUpdate(
            userIdentificationBack: backKey,
            userIdentificationFront: frontKey));
      }
      // handle back image upload
    } else if (value is ErrorResponse) {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }

  void updateUserApi(
      AadharIdentificationUpdate aadharIdentificationUpdate) async {
    Future<dynamic> future = UpdateUserRepository()
        .updateIdentificationPhoto(api: aadharIdentificationUpdate);
    future.then((value) => {handleResponseData(value)});
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
      showSnackbar(context, "Aadhar Card Updated");
      InternetChecks.closeLoadingProgress(context);
      Navigator.pop(context);
      //print("Response Data : ${value.statusCode}");
    } else if (value is ErrorResponse) {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }

  Future<bool> handleFrontImageUpload(FrontVerificationUrl? value) async {
    if (value?.url != null && value?.key != null) {
      var uploadUrl = value?.url!;
      frontKey = value?.key;
      var isUploaded = AwsApi().uploadImage(uploadUrl!, frontImageFile!);
      return isUploaded;
    } else {
      return false;
    }
  }

  Future<bool> handleBackImageUpload(BackVerificationUrl? value) async {
    if (value?.url != null && value?.key != null) {
      var uploadUrl = value?.url!;
      backKey = value?.key;
      var isUploaded = AwsApi().uploadImage(uploadUrl!, frontImageFile!);
      return isUploaded;
    } else {
      return false;
    }
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
                    InternetChecks.isConnected().then((isInternetAvailable) =>
                        {uploadAadhar(isInternetAvailable)});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
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

  void uploadAadhar(bool isInternetAvailable) {
    if (isInternetAvailable) {
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
      InternetChecks.showLoadingCircle(context);
      var a = viewModel.getIdentificationUrl();
      a.then((value) => handleData(value));
    } else {
      showSnackbar(context, "No Internet");
    }
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
