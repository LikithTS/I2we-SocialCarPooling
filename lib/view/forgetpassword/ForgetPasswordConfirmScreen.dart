import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';

import '../../util/CPString.dart';
import '../../util/Validation.dart';
import '../../util/color.dart';
import '../../util/configuration.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../util/string_url.dart';
import '../../utils/Localization.dart';
import '../../widgets/edit_text_widgets.dart';
import '../../widgets/header_widgets.dart';
import '../../widgets/image_widgets.dart';

class ForgetPasswordConfirmScreen extends StatefulWidget {
  const ForgetPasswordConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordConfirmScreen> createState() =>
      _ForgetPasswordConfirmScreenState();
}

class _ForgetPasswordConfirmScreenState
    extends State<ForgetPasswordConfirmScreen> with InputValidationMixin {
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  headerLayout(
                      context,
                      DemoLocalizations.of(context)!
                          .getText("forgot_password")),
                  const SizedBox(
                    height: 50,
                  ),
                  imageAssets(StringUrl.verifyPinImage, 200, 200),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: inputEditTextWithPrefixWidget(
                        context,
                        DemoLocalizations.of(context)!.getText("new_password"),
                        newPassController,
                        CPString.mobileError,
                        Icons.password,
                        4,
                        10,
                        this,
                        ""),
                  ),
                  addHorizontalSpace(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: inputEditTextWithPrefixWidget(
                        context,
                        DemoLocalizations.of(context)!
                            .getText("confirm_password"),
                        confirmPassController,
                        CPString.mobileError,
                        Icons.password,
                        4,
                        10,
                        this,
                        ""),
                  ),
                  Container(
                    width: deviceWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: margin20),
                    margin: EdgeInsets.only(top: margin20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(margin20),
                        ),
                        elevation: margin2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(margin20),
                        child: Text(
                          DemoLocalizations.of(context)!
                              .getText("change_password"),
                          style: TextStyle(fontSize: fontSize18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
