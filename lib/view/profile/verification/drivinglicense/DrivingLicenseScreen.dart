import 'dart:io';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/network/response/driver/DrivingLicenseUpdate.dart';
import 'package:common/network/response/user/ProfileImageUploadUrl.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/imageupload/AwsApi.dart';
import 'package:socialcarpooling/view/profile/verification/aadhar/VerificationViewModel.dart';

import '../../../../font&margin/font_size.dart';
import '../../../../font&margin/margin_confiq.dart';
import '../../../../util/InternetChecks.dart';
import '../../../../util/color.dart';
import '../../../../util/Localization.dart';
import '../../../../widgets/widget_text.dart';
import '../../../../widgets/aleart_widgets.dart';

class DrivingLicenseScreen extends StatefulWidget {
  const DrivingLicenseScreen({Key? key}) : super(key: key);

  @override
  State<DrivingLicenseScreen> createState() => _DrivingLicenseScreenState();
}

class _DrivingLicenseScreenState extends State<DrivingLicenseScreen> {
  VerificationViewModel viewModel = VerificationViewModel();
  File? licenseFile = null;

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
                            ?.getText("add_driving_license") ??
                        "")
                  ],
                ),
                addVerticalSpace(20),
                displayLicense(),
                addVerticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    InternetChecks.isConnected().then((isInternetAvailable) =>
                        {uploadLicense(isInternetAvailable)});
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

  @override
  void initState() {
    super.initState();
    viewModel.getIdentificationUrl();
  }

  Widget displayLicense() {
    if (licenseFile == null) {
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
                          licenseFile = value;
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
                        const Text("Driving Licence Not Selected"),
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
                            licenseFile = value;
                          })
                      });
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(licenseFile!,
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

  void uploadLicense(bool isInternetAvailable) {
    if (isInternetAvailable) {
      // get upload url
      InternetChecks.showLoadingCircle(context);
      if (licenseFile != null) {
        var a = viewModel.getUserDrivingLicenseUrl();
        a.then((value) => handleDrivingLicenseURlData(value));
      }
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  handleDrivingLicenseURlData(value) {
    if (value is ProfileImageUpload) {
      if (value.url != null && value.key != null) {
        var uploadUrl = value.url!;
        var uploadKey = value.key!;
        var isUploaded = AwsApi().uploadImage(uploadUrl, licenseFile!);
        isUploaded.then(
            (value) => handleProfileDrivingLicenseUpdate(value, uploadKey));
      }
    }
  }

  handleProfileDrivingLicenseUpdate(bool value, String key) {
    if (value) {
      updateUserApi(DrivingLicenseUpdate(drivingLicence: key));
    } else {
      showSnackbar(context, "Something went wrong please try again");
    }
  }

  void updateUserApi(DrivingLicenseUpdate profileImage) async {
    Future<dynamic> future =
        UpdateUserRepository().updateDrivingLicensePhoto(api: profileImage);
    future.then((value) => {handleResponseData(value)});
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, "Driving License Updated");
      Navigator.pop(context);
      print("UPdate success$value");
      //print("Response Data : ${value.statusCode}");
    } else if (value is ErrorResponse) {
      InternetChecks.closeLoadingProgress(context);
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }
}
