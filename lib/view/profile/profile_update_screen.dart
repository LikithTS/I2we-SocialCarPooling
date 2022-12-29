import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/network/response/profile/UpdateUserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/font&margin/margin_confiq.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/profile/util/GetProfileDetails.dart';
import 'package:socialcarpooling/widgets/header_widgets.dart';

import '../../util/AppPreference.dart';
import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../utils/Localization.dart';
import '../../widgets/edit_text_widgets.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen>
    with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailNoController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  int genderId = 0;
  String selectedValueGender = "Gender";
  String selectedValueEducation = "Education";
  String selectedValueWork = "Work";
  String dob = "";

  @override
  void initState() {
    super.initState();
    fullNameController.text = AppPreference().userDetail?.name ?? "";
    mobileNoController.text = AppPreference().userDetail?.phoneNumber ?? "";
    emailNoController.text = AppPreference().userDetail?.email ?? "";
    workController.text = AppPreference().userDetail?.work ?? "";
    if(AppPreference().userDetail != null && AppPreference().userDetail?.dob != null) {
      dateController.text =
          getFormattedDate(DateTime.parse(AppPreference().userDetail?.dob ?? ""));
    }
    selectedValueGender = AppPreference().userDetail?.gender ?? "Gender";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              /*  Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getBackButton(),
                  ),
                  Text('Sign Up', style: TextStyleUtils.primaryTextBold)
                ],
              ),*/
              headerLayout(
                  context,
                  DemoLocalizations.of(context)?.getText("update_profile") ??
                      ""),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(
                    context,
                    CPString.fullName,
                    fullNameController,
                    CPString.fullNameError,
                    Icons.person,
                    1,
                    20,
                    this,
                    ''),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(
                    context,
                    CPString.mobileNo,
                    mobileNoController,
                    CPString.mobileError,
                    Icons.mobile_screen_share_outlined,
                    2,
                    10,
                    this,
                    ''),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(
                    context,
                    CPString.email,
                    emailNoController,
                    CPString.emailError,
                    Icons.email,
                    3,
                    30,
                    this,
                    AppPreference().userDetail?.email ?? ""),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 2,
                      shadowColor: borderColor,
                      child: Container(
                          width: deviceWidth(context) * .3,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: selectedValueGender,
                                    hint: const Text(
                                      CPString.gender,
                                      style: TextStyleUtils.primaryTextMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: dataGenderList.map((list) {
                                      return DropdownMenuItem(
                                        value: list.toString(),
                                        child: Text(list),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValueGender = value.toString();
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      StringUrl.downArrowImage,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    width: deviceWidth(context) * .6,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 2,
                      shadowColor: borderColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          controller: dateController,
                          decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            ),
                            suffixIcon: Icon(
                              Icons.edit,
                              color: primaryColor,
                            ),
                            border: InputBorder.none,
                            labelText: CPString.selectDate,
                            labelStyle: TextStyleUtils.hintTextStyle,
                            hintText: CPString.selectDate,
                            hintStyle: TextStyleUtils.hintTextStyle,
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _selectDate();
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.isEmpty) {
                              return CPString.selectDate;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(
                    context,
                    CPString.work,
                    workController,
                    CPString.emailError,
                    Icons.work,
                    3,
                    15,
                    this,
                    ''),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 2,
                  shadowColor: borderColor,
                  child: Container(
                      width: deviceWidth(context) * .3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedValueEducation,
                                hint: const Text(
                                  'Education',
                                  style: TextStyleUtils.primaryTextMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: dataEducationList.map((list) {
                                  return DropdownMenuItem(
                                    value: list.toString(),
                                    child: Text(list),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueEducation = value.toString();
                                  });
                                },
                                icon: SvgPicture.asset(
                                  StringUrl.downArrowImage,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    updateUser();
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
    );
  }

  Future _selectDate() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(AppPreference().userDetail?.dob ?? ""),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    if (picker != null) {
      setState(() {
        dob = getFormattedTime(picker);
        dateController.text = dob;
      });
    }
  }

  void updateUser() {
    if (fullNameController.text.isEmpty) {
      print("full name cannot be empty");
      return;
    }

    if (emailNoController.text.isEmpty) {
      print("email cannot be empty");
      return;
    }
    if (dateController.text.isEmpty) {
      print("date cannot be empty");
      return;
    }
    if (workController.text.isEmpty) {
      print("work cannot be empty");
      return;
    }
    if (selectedValueEducation.isEmpty) {
      print("education cannot be empty");
      return;
    }
    UpdateUserProfile updaterUserApi = UpdateUserProfile(
        work: workController.text,
        education: selectedValueEducation,
        language: AppPreference().userDetail?.language ?? []);

    updateUserApi(updaterUserApi, context);
  }

  void updateUserApi(UpdateUserProfile updaterUserApi, BuildContext context) {
    Future<dynamic> future =
        UpdateUserRepository().updateUserDetails(api: updaterUserApi);
    future.then((value) => {handleResponseData(value, context)});
  }

  handleResponseData(value, BuildContext context) {
    if (value is SuccessResponse) {
      print("UPdate success" + value.toString());
      GetProfileDetails(context);
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
