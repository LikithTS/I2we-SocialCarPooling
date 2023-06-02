import 'dart:developer';

import 'package:common/network/request/signinapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/font&margin/margin_confiq.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/sign_up/sign_up_address.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';
import 'package:socialcarpooling/widgets/header_widgets.dart';

import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../util/Localization.dart';
import '../../widgets/edit_text_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailNoController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  late bool _passwordVisible;
  late bool _cpasswordVisible;
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  int genderId = 0;
  String selectedValueGender = "Gender";
  String selectedValueEducation = "Education";
  String selectedValueWork = "Work";
  String apiValueGender = "";
  String apiValueEducation = "";
  String dob = "";
  int age = 0;

  Future _registration(name, mobile) async {
    if (apiValueGender.isEmpty) {
      showSnackbar(context, "Please select gender");
    } else if (apiValueEducation.isEmpty) {
      showSnackbar(context, "Please select education");
    } else if (emailNoController.text.toString().isEmpty) {
      showSnackbar(context, "Please enter valid email id");
    } else if (mobile.isEmpty) {
      showSnackbar(context, "Please enter valid mobile number");
    } else if (passwordController.text.toString().isEmpty ||
        cpasswordController.text.toString().isEmpty) {
      showSnackbar(context, "Please enter password");
    } else if (passwordController.text.toString() !=
        cpasswordController.text.toString()) {
      showSnackbar(context, "Password is not matching");
    } else {
      SignInApi api = SignInApi(
          name: name,
          education: apiValueEducation,
          gender: apiValueGender,
          email: emailNoController.text.toString(),
          age: age,
          dob: dob,
          address1: '',
          address2: '',
          city: '',
          state: '',
          pincode: '',
          phoneNumber: mobile,
          work: workController.text.toString(),
          password: passwordController.text.toString());
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: SignUpAddress(
                signInApi: api,
              )));
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _cpasswordVisible = false;
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
              headerLayout(context, CPString.signUp),
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
                    '',
                    false),
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
                    '',
                    false),
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
                    '',
                    false),
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
                            padding: const EdgeInsets.only(
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
                                    items: uiGenderList.map((list) {
                                      return DropdownMenuItem(
                                        value: list.toString(),
                                        child: Text(list),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      apiValueGender = getGenderApiKey(value);
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            fillColor: greyColor,
                            enabledBorder: UnderlineInputBorder(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.error_outline),
                      onPressed: () {
                        alertWidgets(
                            context,
                            CPString.passwordInfo,
                            DemoLocalizations.of(context)
                                ?.getText("password_info"));
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        alertWidgets(
                            context,
                            CPString.passwordInfo,
                            DemoLocalizations.of(context)
                                ?.getText("password_info"));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            CPString.passwordInfo,
                            style: TextStyleUtils.primaryTextRegular
                                .copyWith(fontSize: 14),
                          )),
                    )
                  ],
                ),
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
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        fillColor: greyColor,
                        counterText: "",
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: primaryColor),
                        ),
                        labelText: CPString.password,
                        hintText: CPString.password,
                        labelStyle: TextStyleUtils.hintTextStyle,
                        hintStyle: TextStyleUtils.hintTextStyle,
                        // Here is key idea
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            Icons.visibility,
                            color:
                                _passwordVisible ? Colors.black : primaryColor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return CPString.passwordError;
                        } else {
                          if (!regex.hasMatch(value)) {
                            return CPString.passwordValidError;
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 2,
                  shadowColor: borderColor,
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: cpasswordController,
                      obscureText: !_cpasswordVisible,
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        counterText: "",
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        labelText: CPString.confirmPassword,
                        hintText: CPString.confirmPassword,
                        labelStyle: TextStyleUtils.hintTextStyle,
                        hintStyle: TextStyleUtils.hintTextStyle,
                        // Here is key idea
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            Icons.visibility,
                            color:
                                _cpasswordVisible ? Colors.black : primaryColor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _cpasswordVisible = !_cpasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return CPString.cPasswordError;
                        } else if (isPasswordValid(value)) {
                          return CPString.passwordValidError;
                        } else if (passwordController.text.toString() !=
                            value) {
                          return CPString.cPasswordValidError;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              /*  Container(
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
                                value: selectedValueWork,

                                hint:  Text(
                                  'Work',
                                  style: TextStyleUtils.primaryTextMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: dataWorkList.map((list) {
                                  return DropdownMenuItem(
                                    value: list.toString(),
                                    child: Text(list),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueWork = value.toString();
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/svgimages/down_arrow.svg',
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(
                    context,
                    CPString.work,
                    workController,
                    CPString.emailError,
                    Icons.work,
                    5,
                    30,
                    this,
                    '',
                    false),
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
                                items: uiEducationList.map((list) {
                                  return DropdownMenuItem(
                                    value: list.toString(),
                                    child: Text(list),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  apiValueEducation = getEducationValue(value);
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
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registration(
                          fullNameController.text, mobileNoController.text);
                    }
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
                      CPString.continueString,
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
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    if (picker != null) {
      age = calculateAge(picker);
      log("Age is $age");
      setState(() {
        String formattedDate = DateFormat('dd,MMM,yyyy').format(picker);
        dob = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(picker);
        dateController.text = formattedDate;
      });
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    log("Age during calculation $age");
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }

    return age;
  }

  String getGenderApiKey(Object? value) {
    switch (value) {
      case "Male":
        return Constant.MALE;
      case "Female":
        return Constant.FEMALE;
      default:
        return "";
    }
  }

  String getEducationValue(Object? value) {
    switch (value) {
      case "Primary Education":
        return Constant.PRIMARY_EDUCATION;
      case "Secondary Education":
        return Constant.SECONDARY_EDUCATION;
      case "Bachelors Degree":
        return Constant.BACHELORS_DEGREE;
      case "Master Degree":
        return Constant.MASTERS_DEGREE;
      case "Other":
        return Constant.OTHER;
      default:
        return "";
    }
  }
}
