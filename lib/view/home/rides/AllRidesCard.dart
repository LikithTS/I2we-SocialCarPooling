import 'dart:developer';

import 'package:common/network/ApiConstant.dart';
import 'package:common/network/model/Driver.dart';
import 'package:common/network/model/Invites.dart';
import 'package:common/network/model/TravelledPassengers.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RideStatusApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/ride_status_text_function.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/view/home/rides/available_rides_screen.dart';
import 'package:socialcarpooling/view/home/rides/invite_rides_card.dart';
import 'package:socialcarpooling/view/home/rides/join_ride_driver_card.dart';
import 'package:socialcarpooling/view/home/rides/join_ride_passenger_card.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_routes_screen.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../../buttons/elevated_button_view.dart';
import '../../../buttons/outline_button_view.dart';
import '../../../util/constant.dart';
import '../../../util/Localization.dart';
import '../../../util/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_amount_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_widgets.dart';

class AllRidesCard extends StatelessWidget {
  final String rideId;
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final DateTime dateTime;
  final String carType;

  const AllRidesCard(
      {Key? key,
        required this.rideId,
        required this.carIcon,
        required this.startAddress,
        required this.endAddress,
        required this.dateTime,
        required this.carType,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Card(
                    child: Container(
                      width: screenWidth * 0.90,
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            primaryTextNormalTwoLine(
                                                context, endAddress),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const Divider(
                            color: greyColor,
                          ),
                          const Divider(
                            color: greyColor,
                          ),
                        ],
                      ),
                    )),

                //For invite card


                //For Joined driver cards
              ],
            ),
          ),
        ));
  }






  getRideType(String? type) {
    if (type == Constant.AS_HOST) {
      return Constant.AS_RIDER;
    } else {
      return Constant.AS_HOST;
    }
  }






}
