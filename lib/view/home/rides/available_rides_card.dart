import 'dart:developer';

import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/InviteRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../buttons/elevated_button_view.dart';
import '../../../util/constant.dart';
import '../../../util/Localization.dart';
import '../../../util/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/text_widgets.dart';

class AvailableRides extends StatefulWidget {
  final String profileImage;
  final String carIcon;
  final String startAddress;
  final String endAddress;
  final String rideType;
  final int amount;
  final DateTime dateTime;
  final int seatsOffered;
  final String carType;
  final String name;
  final String designation;
  final String phoneNumber;
  final int routeMatch;
  final int profileMatch;
  final String carTypeInterested;
  final String driverRideId;
  final String passengerRideId;

  const AvailableRides(
      {Key? key,
      required this.name,
      required this.phoneNumber,
      required this.designation,
      required this.carType,
      required this.routeMatch,
      required this.carIcon,
      required this.startAddress,
      required this.endAddress,
      required this.profileMatch,
      required this.rideType,
      required this.amount,
      required this.dateTime,
      required this.seatsOffered,
      required this.profileImage,
      required this.carTypeInterested,
      required this.driverRideId,
      required this.passengerRideId})
      : super(key: key);

  @override
  State<AvailableRides> createState() => _AvailableRidesState();
}

class _AvailableRidesState extends State<AvailableRides> {
  bool _hasCallSupport = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Card(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5.0),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: lightGreyColor,
                            backgroundImage: NetworkImage(widget.profileImage)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  availableRidesText(widget.name, greyColor,
                                      18.sp, FontWeight.w400),
                                  availableRidesText(widget.designation,
                                      primaryColor, 10.sp, FontWeight.w400),
                                  if (widget.rideType == Constant.AS_HOST) ...[
                                    availableRidesText(widget.carType,
                                        greyColor, 11.sp, FontWeight.w400)
                                  ]
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          color: const Color(0XffE0F2FF),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.repeat,
                                    color: primaryColor,
                                  ),
                                  availableRidesText("${widget.routeMatch}%",
                                      greyColor, 16.sp, FontWeight.w400)
                                ],
                              ),
                              availableRidesCenterText(
                                  DemoLocalizations.of(context)
                                          ?.getText("route_match") ??
                                      "",
                                  primaryColor,
                                  8.sp,
                                  FontWeight.w400)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: greyColor,
                ),
                Row(
                  children: [
                    if (widget.rideType == Constant.AS_HOST) ...[
                      Expanded(
                          flex: 2,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: lightGreyColor,
                              backgroundImage: NetworkImage(CPSessionManager()
                                  .getCarImage(widget.carIcon)))),
                      const SizedBox(width: 15),
                    ],
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.route_rounded),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  primaryThemeTextNormal(
                                      context,
                                      DemoLocalizations.of(context)
                                          ?.getText("from")),
                                  primaryTextNormalTwoLine(
                                      context, widget.startAddress),
                                  primaryThemeTextNormal(
                                      context,
                                      DemoLocalizations.of(context)
                                          ?.getText("to")),
                                  primaryTextNormalTwoLine(
                                      context, widget.endAddress),
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          color: const Color(0Xfffee9eb),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(0Xfff86565),
                                  ),
                                  availableRidesText("${widget.profileMatch}%",
                                      greyColor, 16.sp, FontWeight.w400)
                                ],
                              ),
                              availableRidesCenterText(
                                  DemoLocalizations.of(context)
                                          ?.getText("profile_match") ??
                                      "",
                                  const Color(0Xfff86565),
                                  8.sp,
                                  FontWeight.w400)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: greyColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: timeView(Icons.calendar_today_sharp,
                          getFormattedDate(widget.dateTime)),
                    ),
                    Expanded(
                      child: timeView(
                          Icons.schedule, getFormattedTime(widget.dateTime)),
                    ),
                    if (widget.rideType == Constant.AS_HOST) ...[
                      Expanded(
                        child: timeView(Icons.airline_seat_recline_normal,
                            widget.seatsOffered.toString()),
                      ),
                    ] else ...[
                      Expanded(
                        child: timeView(
                            Icons.directions_car, widget.carTypeInterested),
                      ),
                    ]
                  ],
                ),
                if (widget.rideType == Constant.AS_HOST) ...[
                  const Divider(
                    color: greyColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Requested Fair",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyleUtils.primaryTextRegular.copyWith(
                              color: greyColor,
                              fontSize: fontSize13,
                              letterSpacing: 1,
                            )),
                        timeViewGreen(
                            Icons.currency_rupee, widget.amount.toString()),
                      ],
                    ),
                  )
                ],
                const Divider(
                  color: greyColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        child: IconButton(
                          onPressed: () {
                            if(_hasCallSupport) {
                              _launched =
                                  _makePhoneCall(widget.phoneNumber);
                            }
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (widget.rideType == Constant.AS_HOST) ...[
                        elevatedButtonView(
                            DemoLocalizations.of(context)?.getText("join") ??
                                "",
                            () => sendRideRequestData(context)),
                      ] else ...[
                        elevatedButtonView(
                            DemoLocalizations.of(context)?.getText("invite") ??
                                "",
                            () => sendRideRequestData(context)),
                      ],
                      FutureBuilder<void>(
                          future: _launched, builder: _launchStatus),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget availableRidesText(
          String? title, Color color, double size, FontWeight fontWeight) =>
      Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(title!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: size,
                  decoration: TextDecoration.none,
                  color: color,
                  fontWeight: fontWeight,
                  fontFamily: 'Poppins')),
        ),
      );

  Widget availableRidesCenterText(
          String? title, Color color, double size, FontWeight fontWeight) =>
      Align(
        alignment: Alignment.center,
        child: Text(title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size,
                decoration: TextDecoration.none,
                color: color,
                fontWeight: fontWeight,
                fontFamily: 'Poppins')),
      );

  sendRideRequestData(BuildContext context) {
    InternetChecks.isConnected().then((isAvailable) => {
          sendRideRequest(isAvailable, context, widget.rideType,
              widget.driverRideId, widget.passengerRideId)
        });
  }

  sendRideRequest(bool isAvailable, BuildContext context, String rideType,
      String driverRideId, String passengerRideId) {
    if (isAvailable) {
      InternetChecks.showLoadingCircle(context);
      RideRepository rideRepository = RideRepository();
      InviteRideApi inviteRideApi = InviteRideApi(
          asDriverId: driverRideId,
          asPassengerId: passengerRideId,
          type: getType(rideType));
      Future<dynamic> future = rideRepository.inviteRide(api: inviteRideApi);
      future.then((value) => {handleResponseData(context, value)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  getType(String rideType) {
    if (rideType == Constant.AS_HOST) {
      return Constant.REQUEST;
    } else {
      return Constant.INVITE;
    }
  }

  handleResponseData(BuildContext context, value) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      // Handle status
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }
}
