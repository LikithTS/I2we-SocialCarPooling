import 'package:flutter/material.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_amount_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_widgets.dart';

class MyRides extends StatelessWidget {
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final String rideType;
  final int amount;
  final DateTime dateTime;
  final int seatsOffered;
  final String carType;
  final String coRidersCount;
  final String leftButtonText;
  final String rideStatus;

  const MyRides(
      {Key? key,
      required this.carIcon,
      required this.startAddress,
      required this.endAddress,
      required this.rideType,
      required this.amount,
      required this.dateTime,
      required this.seatsOffered,
      required this.carType,
      required this.coRidersCount,
      required this.leftButtonText,
      required this.rideStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Card(
              child: Container(
            width: screenWidth * 0.85,
            margin: const EdgeInsets.all(5.0),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(carIcon,
                          width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.route_rounded),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  primaryThemeTextNormal(
                                      context,
                                      DemoLocalizations.of(context)
                                          ?.getText("from")),
                                  primaryTextNormalTwoLine(
                                      context, startAddress),
                                  primaryThemeTextNormal(
                                      context,
                                      DemoLocalizations.of(context)
                                          ?.getText("to")),
                                  primaryTextNormalTwoLine(context, endAddress),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Column(
                          children: [
                            if (rideType == Constant.AS_HOST) ...[
                              rideTypeView(DemoLocalizations.of(context)
                                  ?.getText("as_host")),
                            ] else ...[
                              rideTypeView(DemoLocalizations.of(context)
                                  ?.getText("as_rider")),
                            ],
                            const SizedBox(
                              height: 10,
                            ),
                            if (rideType == Constant.AS_HOST) ...[
                              rideAmountView(amount)
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeView(Icons.calendar_today_sharp,
                          getFormattedDate(dateTime)),
                      timeView(Icons.schedule, getFormattedTime(dateTime)),
                      if (rideType == Constant.AS_HOST) ...[
                        timeView(Icons.airline_seat_recline_normal,
                            seatsOffered.toString()),
                      ]
                    ],
                  ),
                ),
                if (rideType == Constant.AS_RIDER) ...[
                  const Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        timeView(Icons.directions_car, carType),
                      ],
                    ),
                  ),
                ],
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      if (rideType == Constant.AS_RIDER) ...[
                        primaryTextNormalTwoLine(
                            context,
                            DemoLocalizations.of(context)
                                ?.getText("join_ride_to_see") ??
                                ""),
                      ] else ...[
                        primaryTextNormalTwoLine(
                            context,
                            DemoLocalizations.of(context)
                                ?.getText("invite_ride_to_see") ??
                                ""),
                      ]
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (leftButtonText.isNotEmpty) ...[
                        outlineButtonView(leftButtonText, () {}),
                      ],
                      elevatedButtonView(
                          DemoLocalizations.of(context)?.getText("check_in") ??
                              "",
                          () {})
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    ));
  }
}

Widget outlineButtonView(String buttonName, VoidCallback onClick) =>
    OutlinedButton(
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            minimumSize: const Size(150, 40)),
        onPressed: () {
          onClick;
        },
        child: Text(
          buttonName,
          style: const TextStyle(color: Colors.blue),
        ));

Widget elevatedButtonView(String buttonName, VoidCallback onClick) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0Xff1D883A),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            minimumSize: const Size(150, 40)),
        onPressed: () {
          onClick;
        },
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.2,
            fontFamily: 'PoppinsBold',
          ),
        ));
