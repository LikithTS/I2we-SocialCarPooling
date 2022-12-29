import 'dart:developer';

import 'package:common/network/ApiConstant.dart';
import 'package:common/network/model/Driver.dart';
import 'package:common/network/model/Invites.dart';
import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/TravelledPassengers.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RideStatusApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/utils/ride_status_text_function.dart';
import 'package:socialcarpooling/view/home/rides/available_rides_screen.dart';
import 'package:socialcarpooling/view/home/rides/invite_rides_card.dart';
import 'package:socialcarpooling/view/home/rides/join_ride_driver_card.dart';
import 'package:socialcarpooling/view/home/rides/join_ride_passenger_card.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../../buttons/elevated_button_view.dart';
import '../../../buttons/outline_button_view.dart';
import '../../../util/TextStylesUtil.dart';
import '../../../util/color.dart';
import '../../../util/configuration.dart';
import '../../../utils/Localization.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../utils/widget_functions.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_widgets.dart';
import '../../map/map_screen.dart';

class MyRideRoutesView extends StatelessWidget {
  final String rideId;
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final StartLocation startLocation;
  final StartLocation endLocation;
  final String rideType;
  final int amount;
  final DateTime dateTime;
  final int seatsOffered;
  final String carType;
  final int coRidersCount;
  final String leftButtonText;
  final String rideStatus;
  final VoidCallback refreshScreen;
  final List<Invites> invites;
  final List<TravelledPassengers> travelledPassengers;
  final AsDriver? driverRide;

  const MyRideRoutesView(
      {Key? key,
      required this.rideId,
      required this.carIcon,
      required this.startAddress,
      required this.endAddress,
      required this.startLocation,
      required this.endLocation,
      required this.rideType,
      required this.amount,
      required this.dateTime,
      required this.seatsOffered,
      required this.carType,
      required this.coRidersCount,
      required this.leftButtonText,
      required this.rideStatus,
      required this.refreshScreen,
      required this.invites,
      required this.travelledPassengers,
      required this.driverRide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: deviceHeight(context) * .50,
            child: MapScreen(
              gpsIconShow: false,
              directionAlreadyAvailable: true,
              startLocation: startLocation,
              endLocation: endLocation,
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.message),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text('1'),
                          ),
                        )
                      ],
                    ),
                    addHorizontalSpace(10),
                    Stack(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.notifications),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text('1'),
                          ),
                        )
                      ],
                    ),
                    addHorizontalSpace(10),
                  ],
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.5,
            maxChildSize: 0.9,
            initialChildSize: 0.5,
            builder:
                (BuildContext context, ScrollController myScrollController) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                child: Container(
                  color: homePageBackgroundColor,
                  child: SingleChildScrollView(
                    controller: myScrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                      child: Image.asset(
                                          'assets/images/car_pool.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
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
                                                      DemoLocalizations.of(
                                                              context)
                                                          ?.getText("from")),
                                                  primaryTextNormalTwoLine(
                                                      context, startAddress),
                                                  primaryThemeTextNormal(
                                                      context,
                                                      DemoLocalizations.of(
                                                              context)
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
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Column(
                                          children: [
                                            if (rideType ==
                                                Constant.AS_HOST) ...[
                                              rideTypeView(
                                                  DemoLocalizations.of(context)
                                                      ?.getText("as_host")),
                                            ] else ...[
                                              rideTypeView(
                                                  DemoLocalizations.of(context)
                                                      ?.getText("as_rider")),
                                            ],
                                            const SizedBox(
                                              height: 10,
                                            ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: timeView(
                                            Icons.calendar_today_sharp,
                                            getFormattedDate(dateTime)),
                                      ),
                                      Expanded(
                                        child: timeView(Icons.schedule,
                                            getFormattedTime(dateTime)),
                                      ),
                                      if (rideType == Constant.AS_HOST) ...[
                                        Expanded(
                                          child: timeView(
                                              Icons.airline_seat_recline_normal,
                                              seatsOffered.toString()),
                                        )
                                      ] else ...[
                                        Expanded(
                                          child: timeView(
                                              Icons.directions_car, carType),
                                        )
                                      ]
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, top: 0, bottom: 0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.add_circle_outline),
                                        color: Colors.blue,
                                        onPressed: () {
                                          //Open available rides screen
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableRidesScreen(
                                                          rideId: rideId,
                                                          rideType: rideType)));
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
                                                    ?.getText(
                                                        "invite_ride_to_see") ??
                                                ""),
                                      ] else if (coRidersCount > 0 &&
                                          rideType == Constant.AS_HOST) ...[
                                        primaryTextNormalTwoLine(
                                            context, coRidersCount.toString()),
                                      ] else ...[
                                        if (rideType == Constant.AS_RIDER &&
                                            rideStatus ==
                                                Constant.RIDE_CREATED) ...[
                                          primaryTextNormalTwoLine(
                                              context,
                                              DemoLocalizations.of(context)
                                                      ?.getText(
                                                          "join_ride_to_see") ??
                                                  ""),
                                        ]
                                      ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (rideStatus ==
                                          Constant.RIDE_CREATED) ...[
                                        Expanded(
                                          child: outlineButtonView(
                                              Constant.BUTTON_CANCEL,
                                              () => cancelRide(
                                                  context, rideType, rideId)),
                                        ),
                                        addHorizontalSpace(10),
                                      ],
                                      Expanded(
                                        child: elevatedButtonView(
                                            getRightButtonText(
                                                rideType, rideStatus),
                                            () => updateRideDetails(
                                                context, rideType, rideId)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),

                          //For invite card
                          if (invites.isNotEmpty) ...[
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Requests',
                                    style: TextStyleUtils.primaryTextRegular,
                                    textAlign: TextAlign.start,
                                  )),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: invites.length,
                                itemBuilder: (context, index) {
                                  return getInviteRideCard(rideType, index);
                                })
                          ],

                          //For Joined passenger cards
                          if (travelledPassengers.isNotEmpty) ...[
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Co-Riders',
                                    style: TextStyleUtils.primaryTextRegular,
                                    textAlign: TextAlign.start,
                                  )),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: travelledPassengers.length,
                                itemBuilder: (context, index) {
                                  return getPassengerJoinedCard(
                                      rideType, index);
                                })
                          ],

                          //For Joined driver cards
                          if (driverRide != null) ...[
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Co-Rider',
                                    style: TextStyleUtils.primaryTextRegular,
                                    textAlign: TextAlign.start,
                                  )),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return getDriverJoinedCard(rideType);
                                })
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
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
                builder: (context) => AvailableRidesScreen(
                      rideId: rideId,
                      rideType: rideType,
                    )));
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

  getRideType(String? type) {
    if (type == Constant.AS_HOST) {
      return Constant.AS_RIDER;
    } else {
      return Constant.AS_HOST;
    }
  }

  Widget getInviteRideCard(String rideType, int index) {
    if (rideType == Constant.AS_HOST) {
      return InviteRideCard(
        inviteId: invites[index].id ?? "",
        profileImage: invites[index].asPassenger?.user?.profileImage ?? "",
        carIcon: invites[index].asPassenger?.car?.carPictures?[0] ?? "",
        startAddress:
            invites[index].asPassenger?.startDestinationFormattedAddress ?? "",
        endAddress:
            invites[index].asPassenger?.endDestinationFormattedAddress ?? "",
        rideType: getRideType(rideType),
        amount: invites[index].asPassenger?.amountPerSeat ?? 0,
        dateTime: getDateTimeFormatter()
            .parse(invites[index].asPassenger!.startTime!),
        seatsOffered: invites[index].asPassenger?.seatsOffered ?? 1,
        carType: invites[index].asPassenger?.car?.carType ?? "",
        name: invites[index].asPassenger?.user?.name ?? "",
        designation: invites[index].asPassenger?.user?.work ?? "",
        carTypeInterested: invites[index].asPassenger?.carTypeInterested ?? "",
        driverRideId: invites[index].asDriverId ?? "",
        passengerRideId: invites[index].asPassengerId ?? "",
        refreshScreen: refreshScreen,
      );
    } else {
      return InviteRideCard(
        inviteId: invites[index].id ?? "",
        profileImage: invites[index].asDriver?.user?.profileImage ?? "",
        carIcon: invites[index].asDriver?.car?.carPictures?[0] ?? "",
        startAddress:
            invites[index].asDriver?.startDestinationFormattedAddress ?? "",
        endAddress:
            invites[index].asDriver?.endDestinationFormattedAddress ?? "",
        rideType: getRideType(rideType),
        amount: invites[index].asDriver?.amountPerSeat ?? 0,
        dateTime:
            getDateTimeFormatter().parse(invites[index].asDriver!.startTime!),
        seatsOffered: invites[index].asDriver?.seatsOffered ?? 1,
        carType: invites[index].asDriver?.car?.carType ?? "",
        name: invites[index].asDriver?.user?.name ?? "",
        designation: invites[index].asDriver?.user?.work ?? "",
        carTypeInterested: invites[index].asDriver?.carTypeInterested ?? "",
        driverRideId: invites[index].asDriverId ?? "",
        passengerRideId: invites[index].asPassengerId ?? "",
        refreshScreen: refreshScreen,
      );
    }
  }

  Widget getPassengerJoinedCard(String rideType, int index) {
    return JoinRidePassengerCard(
      profileImage: travelledPassengers[index].user?.profileImage ?? "",
      name: travelledPassengers[index].user?.name ?? "",
      designation: travelledPassengers[index].user?.work ?? "",
      rideStatus: travelledPassengers[index].riderStatus ?? "",
      refreshScreen: refreshScreen,
    );
  }

  Widget getDriverJoinedCard(String rideType) {
    return JoinRideDriverCard(
      profileImage: driverRide?.user?.profileImage ?? "",
      name: driverRide?.user?.name ?? "",
      designation: driverRide?.user?.work ?? "",
      rideStatus: driverRide?.rideStatus ?? "",
      carType: driverRide?.car?.carType ?? "",
      carIcon: driverRide?.car?.carPictures?[0] ?? "",
      startAddress: driverRide?.startDestinationFormattedAddress ?? "",
      endAddress: driverRide?.endDestinationFormattedAddress ?? "",
      rideType: rideType,
      amount: driverRide?.amountPerSeat ?? 0,
      dateTime: getDateTimeFormatter().parse(driverRide!.startTime!),
      seatsOffered: driverRide?.seatsOffered ?? 1,
      refreshScreen: refreshScreen,
    );
  }
}
