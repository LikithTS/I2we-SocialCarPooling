import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:socialcarpooling/widgets/ride_amount_view.dart';
import 'package:socialcarpooling/widgets/ride_type_view.dart';

import '../../../util/Localization.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/text_widgets.dart';

class JoinRideDriverCard extends StatefulWidget {
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
  final String rideStatus;
  final VoidCallback refreshScreen;

  const JoinRideDriverCard(
      {Key? key,
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
      required this.rideStatus,
      required this.refreshScreen})
      : super(key: key);

  @override
  State<JoinRideDriverCard> createState() => _JoinRideDriverCard();
}

class _JoinRideDriverCard extends State<JoinRideDriverCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Card(
              child: Column(
            children: [
              Container(
                width: screenWidth * 0.90,
                margin: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: NetworkImage(CPSessionManager()
                                        .getCarImage(widget.carIcon)),
                              ),
                              const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(
                                    Icons.verified_user_rounded,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                        ),
                        addHorizontalSpace(10),
                        const Icon(Icons.route_rounded),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              primaryThemeTextNormal(
                                  context,
                                  DemoLocalizations.of(context)
                                      ?.getText("from")),
                              primaryTextNormalTwoLine(
                                  context, widget.startAddress),
                              primaryThemeTextNormal(context,
                                  DemoLocalizations.of(context)?.getText("to")),
                              primaryTextNormalTwoLine(
                                  context, widget.endAddress),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            rideTypeView(DemoLocalizations.of(context)
                                ?.getText("as_host")),
                            addVerticalSpace(10),
                            rideAmountView(widget.amount),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                width: screenWidth * 0.90,
                margin: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundColor: lightGreyColor,
                                    backgroundImage: NetworkImage(
                                        CPSessionManager().getImage(
                                                widget.profileImage) ??
                                            "")),
                                const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.verified_user_rounded,
                                      color: primaryColor,
                                    ))
                              ],
                            ),
                            addHorizontalSpace(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyleUtils.primaryTextSemiBold
                                      .copyWith(color: primaryColor),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.designation,
                                      style: TextStyleUtils.primaryTextRegular
                                          .copyWith(fontSize: 12),
                                      textAlign: TextAlign.start,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: timeView(Icons.calendar_today_sharp,
                              getFormattedDate(widget.dateTime)),
                        ),
                        Expanded(
                          child: timeView(Icons.schedule,
                              getFormattedTime(widget.dateTime)),
                        ),
                        Expanded(
                          child: timeView(Icons.airline_seat_recline_normal,
                              widget.seatsOffered.toString()),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ride Status',
                          style: TextStyleUtils.primaryTextRegular.copyWith(
                              fontSize: 13, color: greyColor, height: 1.3),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          widget.rideStatus,
                          style: TextStyleUtils.primaryTextRegular.copyWith(
                              fontSize: 13, color: Colors.green, height: 1.3),
                          textAlign: TextAlign.start,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    ));
  }
}
