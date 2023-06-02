import 'package:flutter/material.dart';

import '../../../util/Localization.dart';
import '../../../widgets/widget_text.dart';
import '../../../widgets/text_widgets.dart';

class MyAvailableStartPage extends StatefulWidget {
  const MyAvailableStartPage({Key? key}) : super(key: key);

  @override
  State<MyAvailableStartPage> createState() => _MyAvailableStartPageState();
}

class _MyAvailableStartPageState extends State<MyAvailableStartPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Image.asset("assets/images/welcome_user.png",
                          fit: BoxFit.cover)),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: secondaryTextWidget(
                      context,
                      DemoLocalizations.of(context)
                              ?.getText("no_available_ride") ??
                          ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
