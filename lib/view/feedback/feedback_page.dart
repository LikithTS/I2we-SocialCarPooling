import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/font&margin/margin_confiq.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/widgets/button_widgets.dart';

import '../../util/CPString.dart';
import '../../util/string_url.dart';
import '../../utils/Localization.dart';
import '../../widgets/edit_text_widgets.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
          title: Text(DemoLocalizations.of(context)?.getText("feedback") ??
              "Feedback")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: getFeedbackWidget(),
      ),
    );
  }

  getFeedbackWidget() {
    TextEditingController subjectController = TextEditingController();
    TextEditingController commentsController = TextEditingController();
    TextStyle textStyle =
        TextStyleUtils.primaryTextRegular.copyWith(fontSize: fontSize18);
    return Padding(
      padding: EdgeInsets.all(margin16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(CPString.FEEDBACK_DESC, style: textStyle),
          SvgPicture.asset(StringUrl.feedback_image),
          addVerticalSpace(margin16),
          buildFormBuilderTextField(
              "Subject", "Subject", subjectController, TextInputType.name),
          addVerticalSpace(margin16),
          buildFormBuilderMultilineTextField("Comments", "Comments..",
              commentsController, 5, 100, TextInputType.multiline),
          addVerticalSpace(margin16),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: margin20),
                child: secondaryButton(CPString.SUBMIT, () {
                  Navigator.pop(context);
                }),
              ))
        ],
      ),
    );
  }
}
