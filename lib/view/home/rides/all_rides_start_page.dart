
import 'package:common/network/repository/HomeRepository.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/Localization.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/widgets/button_widgets.dart';
import 'package:socialcarpooling/widgets/text_widgets.dart';


class AllRidesStartPage extends StatefulWidget {
  const AllRidesStartPage({Key? key}) : super(key: key);

  @override
  State<AllRidesStartPage> createState() => AllRidesStartPageState();
}

class AllRidesStartPageState extends State<AllRidesStartPage> {
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
                      child: Image.asset("assets/images/add_car.png",
                          fit: BoxFit.fill)),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: primaryBigTextWidget(
                      context,
                      DemoLocalizations.of(context)?.getText("add_ride") ?? "",
                      greyColor),
                ),
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      addVerticalSpace(10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.people,
                              color: primaryColor,
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
                        color: greyColor,
                      ),
                      addVerticalSpace(10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sentiment_satisfied_alt,
                              color: primaryColor,
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
                            ?.getText("add_ride_button") ??
                            "",
                        addRide),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addRide() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop, child: HomePage(homeRepository: HomeRepository())));
  }
}
