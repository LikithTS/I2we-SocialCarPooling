import 'dart:developer';

import 'package:common/network/response/CarDetailsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../utils/Localization.dart';
import '../../utils/widget_functions.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/text_widgets.dart';
import 'my_vehicle_start_page.dart';

class MyCarsScreen extends StatelessWidget {
  final List<CarDetailsResponse> carList;

  const MyCarsScreen(this.carList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  headerText(
                      DemoLocalizations.of(context)?.getText("my_cars_title") ??
                          "")
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: carList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(carList[index].toString()),
                    direction: DismissDirection.endToStart,
                    background: slideLeftBackground(),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        print('Remove item');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 150,
                      width: double.maxFinite,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 30, // Image radius
                                backgroundImage: NetworkImage(
                                    'http://m.gettywallpapers.com/wp-content/uploads/2021/09/Hulk-Wallpaper.jpg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  mycarTextWidget(carList[index].carType,
                                      primaryColor, 18.sp),
                                  mycarTextWidget(carList[index].carName,
                                      Colors.black, 12.sp),
                                  mycarTextWidget(carList[index].regNumber,
                                      primaryColor, 13.sp)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          height: 50,
                                          width: 170,
                                          child: Card(
                                            elevation: 5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .airline_seat_recline_normal,
                                                      color: primaryColor,
                                                    ),
                                                    smallLightText("seats",
                                                        Alignment.center),
                                                  ],
                                                ),
                                                const RotatedBox(
                                                  quarterTurns: 1,
                                                  child: Divider(),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    primaryThemeTextNormal(
                                                        context,
                                                        carList[index]
                                                            .seatingCapacity
                                                            .toString()),
                                                    smallLightText("available",
                                                        Alignment.center),
                                                  ],
                                                ),
                                                const RotatedBox(
                                                  quarterTurns: 1,
                                                  child: Divider(),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    primaryThemeTextNormal(
                                                        context,
                                                        carList[index]
                                                            .offeringSeat
                                                            .toString()),
                                                    smallLightText("offered",
                                                        Alignment.center)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 8.0, 8.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        smallTextWithNoMargin(
                                            "set default :", Alignment.topLeft),
                                        Container(
                                          width: 40,
                                          height: 30,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: CupertinoSwitch(
                                              value: carList[index]
                                                      .drivingStatus ??
                                                  false,
                                              onChanged: (value) {
                                                log("Default value changed $value");
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                  width: size.width,
                  child: primaryButtonWithCallBack(
                      DemoLocalizations.of(context)
                              ?.getText("add_car_button") ??
                          "", () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: const MyVehicleStartPage()));
                  })),
            ),
          ],
        ),
      ),
    ));
  }

  void delete() {}
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}