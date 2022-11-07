import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/text_widgets.dart';

class AvailableRides extends StatelessWidget {
  final String profileImage;
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

  const AvailableRides(
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
      required this.rideStatus,
      required this.profileImage})
      : super(key: key);

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
                        padding: const EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 5),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://free4kwallpapers.com/uploads/wallpaper/incredible-hulk-wallpaper-1024x768-wallpaper.jpg")),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 10, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  availableRidesText("Driver Name",
                                      Colors.black, 18.sp, FontWeight.w400),
                                  availableRidesText("Destination",
                                      primaryColor, 10.sp, FontWeight.w400),
                                  availableRidesText("Car type", Colors.black,
                                      11.sp, FontWeight.w400)
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
                        child: Container(
                          color: Color(0XffE0F2FF),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.repeat,
                                    color: primaryColor,
                                  ),
                                  availableRidesText("98%", Colors.black, 16.sp,
                                      FontWeight.w400)
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
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 5),
                        child: Image.asset(carIcon,
                            width: 60, height: 60, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 10, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.route_rounded),
                            const SizedBox(width: 5),
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
                        child: Container(
                          color: Color(0Xfffee9eb),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Color(0Xfff86565),
                                  ),
                                  availableRidesText("98%", Colors.black, 16.sp,
                                      FontWeight.w400)
                                ],
                              ),
                              availableRidesCenterText(
                                  DemoLocalizations.of(context)
                                          ?.getText("profile_match") ??
                                      "",
                                  Color(0Xfff86565),
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
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      outlineButtonView(leftButtonText, () {}),
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.message_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      elevatedButtonView(
                          DemoLocalizations.of(context)?.getText("join") ?? "",
                          () {},
                          context)
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
    Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size,
                decoration: TextDecoration.none,
                color: color,
                fontWeight: fontWeight,
                fontFamily: 'Poppins')),
      ),
    );

Widget outlineButtonView(String buttonName, VoidCallback onClick) =>
    OutlinedButton(
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            minimumSize: const Size(250, 40)),
        onPressed: () {
          onClick;
        },
        child: Text(
          buttonName,
          style: const TextStyle(color: Colors.blue),
        ));

Widget elevatedButtonView(
        String buttonName, VoidCallback onClick, BuildContext context) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color(0Xff1D883A),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            minimumSize: Size(150, 40)),
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
