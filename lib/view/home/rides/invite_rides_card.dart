import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/JoinRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/buttons/elevated_button_view.dart';
import 'package:socialcarpooling/buttons/outline_button_view.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/text_widgets.dart';

class InviteRideCard extends StatefulWidget {
  final String inviteId;
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
  final String carTypeInterested;
  final String driverRideId;
  final String passengerRideId;
  final VoidCallback refreshScreen;

  const InviteRideCard(
      {Key? key,
      required this.inviteId,
      required this.name,
      required this.designation,
      required this.carType,
      required this.carIcon,
      required this.startAddress,
      required this.endAddress,
      required this.rideType,
      required this.amount,
      required this.dateTime,
      required this.seatsOffered,
      required this.profileImage,
      required this.carTypeInterested,
      required this.driverRideId,
      required this.passengerRideId,
      required this.refreshScreen})
      : super(key: key);

  @override
  State<InviteRideCard> createState() => _InviteRideCard();
}

class _InviteRideCard extends State<InviteRideCard> {
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
                            backgroundImage: NetworkImage(CPSessionManager()
                                    .getImage(widget.profileImage) ??
                                "")),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                          children: [
                            const SizedBox(width: 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  availableRidesText(widget.name, Colors.black,
                                      18.sp, FontWeight.w400),
                                  availableRidesText(widget.designation,
                                      primaryColor, 10.sp, FontWeight.w400),
                                  if (widget.rideType == Constant.AS_HOST) ...[
                                    availableRidesText(widget.carType,
                                        Colors.black, 11.sp, FontWeight.w400)
                                  ]
                                ],
                              ),
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
                Row(
                  children: [
                    if (widget.rideType == Constant.AS_HOST) ...[
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(CPSessionManager()
                                        .getCarImage(widget.carIcon) ??
                                    "")),
                          )),
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
                  ],
                ),
                const Divider(
                  color: Colors.grey,
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
                    color: Colors.grey,
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
                              color: textGreyColor,
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
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.message_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      outlineFullButtonView(
                          Constant.BUTTON_CANCEL,
                          () => cancelRequestData(
                              context, widget.rideType, widget.inviteId)),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: elevatedFullWidthButtonView(
                      'Accept',
                      () => sendRideJoinData(
                          context, widget.rideType, widget.inviteId),
                      Colors.green),
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }

  sendRideJoinData(BuildContext context, rideType, inviteRideId) {
    InternetChecks.isConnected().then(
        (isAvailable) => {sendRideRequest(isAvailable, context, inviteRideId)});
  }

  cancelRequestData(BuildContext context, rideType, inviteRideId) {
    InternetChecks.isConnected().then((isAvailable) =>
        {sendRideCancelRequest(isAvailable, context, inviteRideId)});
  }

  sendRideRequest(bool isAvailable, BuildContext context, String inviteRideId) {
    if (isAvailable) {
      InternetChecks.showLoadingCircle(context);
      RideRepository rideRepository = RideRepository();
      JoinRideApi joinRideApi = JoinRideApi(inviteId: inviteRideId);
      Future<dynamic> future = rideRepository.joinRide(api: joinRideApi);
      future.then((value) => {handleResponseData(context, value)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  sendRideCancelRequest(bool isAvailable, BuildContext context, inviteRideId) {
    if (isAvailable) {
      InternetChecks.showLoadingCircle(context);
      RideRepository rideRepository = RideRepository();
      JoinRideApi joinRideApi = JoinRideApi(inviteId: inviteRideId);
      Future<dynamic> future = rideRepository.inviteCancel(api: joinRideApi);
      future.then((value) => {handleResponseData(context, value)});
    } else {
      showSnackbar(context, "No Internet");
    }
  }

  getType(String rideType) {
    if (rideType == Constant.AS_HOST) {
      return Constant.INVITE;
    } else {
      return Constant.REQUEST;
    }
  }

  handleResponseData(BuildContext context, value) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      // Handle status
      widget.refreshScreen();
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }
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
