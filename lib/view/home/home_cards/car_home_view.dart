import 'dart:core';
import 'dart:developer';

import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/request/drivingStatusApi.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/view/myvehicle/all_car_details_screen.dart';

import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';

class HomeCarCard extends StatefulWidget {
  final String carId;
  final String carType;
  final String carName;
  final String carNumber;
  final int numberOfSeatsOffered;
  final int numberOfSeatsAvailable;
  final String carImage;
  bool defaultStatus;
  final CarRepository carRepository;

  HomeCarCard(
      {Key? key,
      required this.carId,
      required this.carType,
      required this.carName,
      required this.carNumber,
      required this.numberOfSeatsOffered,
      required this.numberOfSeatsAvailable,
      required this.defaultStatus,
      required this.carRepository,
      required this.carImage})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HomeCarCard> {
  bool setDefaultCar = false;
  CarRepository get _carRepository => widget.carRepository;

  void changeDefaultStateOfCar(String id, bool value) {
    DrivingStatusApi api = DrivingStatusApi(carId: id);
    Future<dynamic> future = _carRepository.carDrivingStatusUpdate(api: api);
    future.then((value) => {handleResponseData(value)});
  }

  handleResponseData(value) {
    log("Driving status changed successfully");
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
              child: primaryTextWidgetLeft(context,
                  DemoLocalizations.of(context)?.getText("my_cars_title")),
            ),
            GestureDetector(
              onTap: () {
                // Add page navigation here
                openAddCarPage(context);
              },
              child: Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(CPSessionManager()
                                    .getCarImage(widget.carImage))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                primaryThemeTextWidget(context, widget.carType),
                                primaryTextNormal(context, widget.carName),
                                primaryThemeTextNormal(
                                    context, widget.carNumber)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .airline_seat_recline_normal,
                                                    color: Colors.blue,
                                                  ),
                                                  primaryTextSmall(
                                                      context,
                                                      DemoLocalizations.of(
                                                              context)
                                                          ?.getText("seats")),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  primaryThemeTextWidget(
                                                      context,
                                                      widget
                                                          .numberOfSeatsAvailable
                                                          .toString()),
                                                  primaryTextSmall(
                                                      context,
                                                      DemoLocalizations.of(
                                                              context)
                                                          ?.getText(
                                                              "available")),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  primaryThemeTextWidget(
                                                      context,
                                                      widget
                                                          .numberOfSeatsOffered
                                                          .toString()),
                                                  primaryTextSmall(
                                                      context,
                                                      DemoLocalizations.of(
                                                              context)
                                                          ?.getText("offered")),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      secondaryTextSmall(
                                          context,
                                          DemoLocalizations.of(context)
                                              ?.getText("set_default")),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10, right: 10),
                                        child: CupertinoSwitch(
                                          // This bool value toggles the switch.
                                          value: widget.defaultStatus,
                                          onChanged: (bool value) {
                                            // This is called when the user toggles the switch.
                                            setState(() {
                                              log("Cupertion switch $value");
                                              widget.defaultStatus = value;
                                              changeDefaultStateOfCar(
                                                  widget.carId, value);
                                            });
                                          },
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openAddCarPage(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            child: AllCarDetailsPage(carRepository: CarRepository())));
  }
}
