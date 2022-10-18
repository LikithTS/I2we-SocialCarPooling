import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/CPString.dart';
import 'package:socialcarpooling/util/Validation.dart';
import 'package:socialcarpooling/view/sign_up/verify_otp_page.dart';
import 'package:socialcarpooling/widgets/header_widgets.dart';

import '../../util/color.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../widgets/edit_text_widgets.dart';

class SignUpAddress extends StatefulWidget {
  final String mobileNo;
  const SignUpAddress({Key? key, required this.mobileNo}) : super(key: key);

  @override
  State<SignUpAddress> createState() => _SignUpAddressState();
}

class _SignUpAddressState extends State<SignUpAddress> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  Future _registrationAddress(addressOne,addressTwo) async {

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            child:VerifyOtpPage(mobileNo: widget.mobileNo,)));

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

              headerLayout(context, CPString.signUp),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(context, CPString.address1,
                    addressController, CPString.addressError, Icons.location_on,5,this,''),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(context, CPString.address2,
                    addressTwoController, CPString.addressTwoError, Icons.location_on,5,this,''),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(context, CPString.city,
                    cityController, CPString.cityError, Icons.location_city,5,this,''),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(context, CPString.state,
                    stateController, CPString.stateError, Icons.location_city,5,this,''),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: inputEditTextWithPrefixWidget(context, CPString.zipCode,
                    zipCodeController, CPString.zipCodeError, Icons.local_post_office_outlined,4,this,''),
              ),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registrationAddress(addressController.text,addressTwoController.text);
                    }
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
}
