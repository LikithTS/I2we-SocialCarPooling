import 'package:flutter/material.dart';

import '../../../buttons/elevated_button_view.dart';
import '../../../buttons/outline_button_view.dart';
import '../../../util/constant.dart';
import '../../../utils/ride_status_text_function.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_amount_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_view_bold.dart';
import '../../../widgets/text_view_normal.dart';

class UpcomingRides extends StatelessWidget {
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final String rideType;
  final int amount;
  final String dateTime;
  final String seatsOffered;
  final String carType;
  final String coRidersCount;
  final String leftButtonText;
  final String rideStatus;

  const UpcomingRides(
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
          child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 5, top: 5, bottom: 5),
                  child: Image.asset(carIcon,
                      width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.route_rounded),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textViewBold('From'),
                          textViewNormal(startAddress),
                          textViewBold('To'),
                          textViewNormal(endAddress),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      rideTypeView(rideType),
                      const SizedBox(
                        height: 10,
                      ),
                      if (rideType == Constant.AS_HOST) ...[
                        rideAmountView(amount)
                      ]
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  timeView(Icons.calendar_today_sharp, dateTime),
                  timeView(Icons.schedule, "9:30 AM"),
                  if (rideType == Constant.AS_HOST) ...[
                    timeView(Icons.airline_seat_recline_normal, seatsOffered),
                  ] else ...[
                    timeView(Icons.directions_car, carType),
                  ]
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  textViewNormal(coRidersCount),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (leftButtonText.isNotEmpty) ...[
                    outlineButtonView(leftButtonText),
                  ],
                  elevatedButtonView(getRightButtonText(rideType, rideStatus))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
