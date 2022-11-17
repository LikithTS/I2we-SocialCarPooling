import 'package:flutter/material.dart';

import '../../utils/Localization.dart';
import '../../utils/widget_functions.dart';

class NotificationMainScreen extends StatefulWidget {
  const NotificationMainScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMainScreen> createState() => _NotificationMainScreenState();
}

class _NotificationMainScreenState extends State<NotificationMainScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Container(
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
                  headerText(
                      DemoLocalizations.of(context)?.getText("notification") ??
                          ""),
                ],
              ),
              addVerticalSpace(20),
            ],
          ),
        ),
      )),
    );
  }
}
