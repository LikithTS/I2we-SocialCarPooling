import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../util/color.dart';
import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';

class ProfileCard extends StatelessWidget {
  final String profileName;
  final int profileCompletionPercentage;

  const ProfileCard(
      {Key? key,
      required this.profileName,
      required this.profileCompletionPercentage})
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
                child: primaryTextWidgetLeft(context, DemoLocalizations.of(context)?.getText("my_profile")),
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
                          const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://free4kwallpapers.com/uploads/wallpaper/incredible-hulk-wallpaper-1024x768-wallpaper.jpg")),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryThemeTextWidget(context, profileName),
                                primaryTextNormal(context, DemoLocalizations.of(context)?.getText("complete_profile")),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CircularPercentIndicator(
                              radius: 55,
                              lineWidth: 6,
                              percent: profileCompletionPercentage/100,
                              progressColor: progressThemeColor,
                              backgroundColor: lightGreyColor,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: primaryThemeTextWidget(context,
                                  '${getPercentage(profileCompletionPercentage/100)}%'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        )
    );
  }
}