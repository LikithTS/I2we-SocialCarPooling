import 'package:flutter/material.dart';

import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';

class QuestionnaireCard extends StatelessWidget {
  final double questionnairesCompletionPercentage;

  const QuestionnaireCard(
      {Key? key, required this.questionnairesCompletionPercentage})
      : super(key: key);

  String getPercentage(double percentage) {
    return (percentage * 100).toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: primaryTextWidgetLeft(context, DemoLocalizations.of(context)?.getText("my_questioners")),
            ),
            Card(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              primaryThemeTextWidget(
                                  context, DemoLocalizations.of(context)?.getText("complete_questionnaire")),
                              primaryTextNormal(context,
                                  DemoLocalizations.of(context)?.getText("questionnaire_description")),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          AssetImage('assets/images/circle_right_arrow.png'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}