import 'dart:developer';

import 'package:common/network/ApiConstant.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RideStatusApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/utils/ride_status_text_function.dart';
import 'package:socialcarpooling/view/home/rides/available_rides_screen.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../buttons/elevated_button_view.dart';
import '../../../buttons/outline_button_view.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_amount_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_widgets.dart';
import 'my_ride_routes.dart';

class MyRides extends StatelessWidget {
  final String rideId;
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final String rideType;
  final int amount;
  final DateTime dateTime;
  final int seatsOffered;
  final String carType;
  final int coRidersCount;
  final String leftButtonText;
  final String rideStatus;
  final VoidCallback refreshScreen;

  const MyRides(
      {Key? key,
      required this.rideId,
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
      required this.rideStatus,
      required this.refreshScreen})
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
                        left: 8, right: 8, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        timeView(Icons.calendar_today_sharp,
                            getFormattedDate(dateTime)),
                        timeView(Icons.schedule, getFormattedTime(dateTime)),
                        if (rideType == Constant.AS_HOST) ...[
                          timeView(Icons.airline_seat_recline_normal,
                              seatsOffered.toString()),
                        ] else ...[
                          timeView(Icons.directions_car, carType),
                        ]
                      ],
                    ),
                  ),
                  if (rideStatus != Constant.RIDE_JOINED) ...[
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 5, top: 0, bottom: 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            color: Colors.blue,
                            onPressed: () {
                              //Open available rides screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AvailableRidesScreen(rideId: rideId, rideType: rideType)));
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (coRidersCount == 0 &&
                              rideType == Constant.AS_HOST) ...[
                            primaryTextNormalTwoLine(
                                context,
                                DemoLocalizations.of(context)
                                        ?.getText("invite_ride_to_see") ??
                                    ""),
                          ] else if (coRidersCount > 0 &&
                              rideType == Constant.AS_HOST) ...[
                            primaryTextNormalTwoLine(
                                context, coRidersCount.toString()),
                          ] else ...[
                            if (rideType == Constant.AS_RIDER &&
                                rideStatus == Constant.RIDE_CREATED) ...[
                              primaryTextNormalTwoLine(
                                  context,
                                  DemoLocalizations.of(context)
                                          ?.getText("join_ride_to_see") ??
                                      ""),
                            ]
                          ],
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (rideStatus == Constant.RIDE_CREATED ||
                            rideStatus == Constant.RIDE_STARTED ||
                            rideStatus == Constant.RIDE_JOINED) ...[
                          Expanded(
                            child: outlineButtonView(Constant.BUTTON_CANCEL,
                                    () => cancelRide(context, rideType, rideId)),
                          ),
                        ],
                        addHorizontalSpace(10),
                        Expanded(
                          child: elevatedButtonView(
                              getRightButtonText(rideType, rideStatus),
                                  () => updateRideDetails(context, rideType, rideId)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Co-riders',
                    style: TextStyleUtils.primaryTextRegular,
                    textAlign: TextAlign.start,
                  )),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Column(
                      children: [
                        index == 0
                            ? Card(
                                child: Column(
                                children: [
                                  Container(
                                    width: screenWidth * 0.85,
                                    margin: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 30,
                                                      child: Image.asset(
                                                        "assets/images/car_pool.png",
                                                        width: 60,
                                                        height: 60,
                                                      ),
                                                    ),
                                                    const Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Icon(
                                                          Icons
                                                              .verified_user_rounded,
                                                          color: Colors.green,
                                                        ))
                                                  ],
                                                ),
                                                addHorizontalSpace(10),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.route_rounded),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        primaryThemeTextNormal(
                                                            context,
                                                            DemoLocalizations
                                                                    .of(context)
                                                                ?.getText(
                                                                    "from")),
                                                        primaryTextNormalTwoLine(
                                                            context,
                                                            "startAddress"),
                                                        primaryThemeTextNormal(
                                                            context,
                                                            DemoLocalizations
                                                                    .of(context)
                                                                ?.getText(
                                                                    "to")),
                                                        primaryTextNormalTwoLine(
                                                            context,
                                                            "endAddress"),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                rideTypeView(
                                                    DemoLocalizations.of(
                                                            context)
                                                        ?.getText("as_host")),
                                                addVerticalSpace(10),
                                                Text(
                                                  '₹ 250',
                                                  style: TextStyleUtils
                                                      .primaryTextBold
                                                      .copyWith(
                                                          color: Colors.green),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.85,
                                    margin: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: const [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          primaryColor,
                                                      radius: 30,
                                                      child: Icon(
                                                        Icons.account_circle,
                                                        color: Colors.white,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Icon(
                                                          Icons
                                                              .verified_user_rounded,
                                                          color:
                                                              primaryLightColor,
                                                        ))
                                                  ],
                                                ),
                                                addHorizontalSpace(10),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Co-rider name',
                                                      style: TextStyleUtils
                                                          .primaryTextSemiBold
                                                          .copyWith(
                                                              color:
                                                                  primaryColor),
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Designation',
                                                          style: TextStyleUtils
                                                              .primaryTextRegular
                                                              .copyWith(
                                                                  fontSize: 12),
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const CircleAvatar(
                                              radius: 20,
                                              backgroundColor: primaryColor,
                                              child: Icon(
                                                Icons.message,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              timeView(
                                                  Icons.drive_eta, '24 Rides'),
                                              timeView(Icons.route_rounded,
                                                  '24 Rides'),
                                              timeView(Icons.star, '4.5'),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))
                            : Card(
                                child: Container(
                                width: screenWidth * 0.85,
                                margin: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: const [
                                                CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  radius: 30,
                                                  child: Icon(
                                                    Icons.account_circle,
                                                    color: Colors.white,
                                                    size: 60,
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Icon(
                                                      Icons
                                                          .verified_user_rounded,
                                                      color: primaryLightColor,
                                                    ))
                                              ],
                                            ),
                                            addHorizontalSpace(10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Co-rider name',
                                                  style: TextStyleUtils
                                                      .primaryTextSemiBold
                                                      .copyWith(
                                                          color: primaryColor),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      'Designation',
                                                      style: TextStyleUtils
                                                          .primaryTextRegular
                                                          .copyWith(
                                                              fontSize: 12),
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: primaryColor,
                                          child: Icon(
                                            Icons.message,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          timeView(Icons.drive_eta, '24 Rides'),
                                          timeView(
                                              Icons.route_rounded, '24 Rides'),
                                          timeView(Icons.star, '4.5'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    ));
  }

  void cancelRide(BuildContext context, String rideType, String rideId) {
    log("On Cancelled button clicked");
    if (rideId.isNotEmpty) {
      InternetChecks.isConnected().then((isAvailable) => {
            updateRideStatus(
                isAvailable, context, rideType, rideId, Constant.RIDE_CANCELLED)
          });
    }
  }

  updateRideDetails(BuildContext context, String rideType, String rideId) {
    if (rideId.isNotEmpty) {
      if (rideType == Constant.AS_RIDER &&
          rideStatus == Constant.RIDE_CREATED) {
        // Move to rides available page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AvailableRidesScreen(rideId: rideId, rideType: rideType,)));
      } else if (rideType == Constant.RIDE_JOINED ||
          rideType == Constant.RIDE_STARTED) {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: MyRideRoutes()));
      } else {
        String? status = getStatus(rideStatus, rideType);
        if (status != null && status.isNotEmpty) {
          InternetChecks.isConnected().then((isAvailable) => {
                updateRideStatus(isAvailable, context, rideType, rideId, status)
              });
        }
      }
    }
  }

  updateRideStatus(bool isAvailable, BuildContext context, String rideType,
      String rideId, String rideStatusData) {
    if (isAvailable) {
      InternetChecks.showLoadingCircle(context);
      var apiPath = ApiConstant.RIDE_STATUS_DRIVER;
      if (rideType == Constant.AS_RIDER) {
        apiPath = ApiConstant.RIDE_STATUS_PASSANGER;
      }
      RideRepository rideRepository = RideRepository();
      RideStatusApi rideStatusApi =
          RideStatusApi(rideId: rideId, rideStatus: rideStatusData);
      Future<dynamic> future =
          rideRepository.updateRideStatus(api: rideStatusApi, apiPath: apiPath);
      future.then((value) => {handleCarStatusResponseData(context, value)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  handleCarStatusResponseData(context, value) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      refreshScreen();
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }
}
