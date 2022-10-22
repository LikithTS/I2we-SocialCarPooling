import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/myvehicle/add_car_screen.dart';

import '../../utils/Localization.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/text_widgets.dart';

class MyVehicleStartPage extends StatefulWidget {
  const MyVehicleStartPage({Key? key}) : super(key: key);

  @override
  State<MyVehicleStartPage> createState() => MyVehicleStartPageState();
}

class MyVehicleStartPageState extends State<MyVehicleStartPage> {
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      headerText(DemoLocalizations.of(context)
                              ?.getText("my_cars_title") ??
                          "")
                    ],
                  ),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Image.asset("assets/images/add_car.png",
                          fit: BoxFit.fill)),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: primaryBigTextWidget(
                      context,
                      DemoLocalizations.of(context)?.getText("add_car") ?? "",
                      Colors.black),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.drive_eta,
                              color: textThemeColor,
                            ),
                            addHorizontalSpace(10),
                            primaryTextLightWidgetLeft(
                                context,
                                DemoLocalizations.of(context)
                                        ?.getText("add_car_details_one") ??
                                    "")
                          ]),
                      addVerticalSpace(10),
                      const Divider(
                        color: Colors.grey,
                      ),
                      addVerticalSpace(10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.people,
                              color: textThemeColor,
                            ),
                            addHorizontalSpace(10),
                            primaryTextLightWidgetLeft(
                                context,
                                DemoLocalizations.of(context)
                                        ?.getText("add_car_details_two") ??
                                    "")
                          ]),
                      addVerticalSpace(10),
                      const Divider(
                        color: Colors.grey,
                      ),
                      addVerticalSpace(10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sentiment_satisfied_alt,
                              color: textThemeColor,
                            ),
                            addHorizontalSpace(10),
                            primaryTextLightWidgetLeft(
                                context,
                                DemoLocalizations.of(context)
                                        ?.getText("add_car_details_three") ??
                                    "")
                          ]),
                    ],
                  ),
                ),
                addVerticalSpace(40),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: size.width,
                    child: primaryButtonWithCallBack(
                        DemoLocalizations.of(context)
                                ?.getText("add_car_button") ??
                            "",
                        addCar),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCar() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop, child: const AddCarScreen()));
  }
}
