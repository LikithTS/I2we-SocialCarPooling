import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';

import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';


class HomeCarCard extends StatefulWidget {
  final String carType;
  final String carName;
  final String carNumber;
  final int numberOfSeatsOffered;
  final int numberOfSeatsAvailable;
  final bool defaultStatus;

  const HomeCarCard({Key? key,
    required this.carType,
    required this.carName,
    required this.carNumber,
    required this.numberOfSeatsOffered,
    required this.numberOfSeatsAvailable,
    required this.defaultStatus,
  })
      : super(key: key);

  @override
  _State createState() => _State();

}

class _State extends State<HomeCarCard> {
  bool setDefaultCar = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: primaryTextWidgetLeft(context, DemoLocalizations.of(context)?.getText("my_cars_title")),
            ),
            Card(
              child: Container(
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://free4kwallpapers.com/uploads/wallpaper/incredible-hulk-wallpaper-1024x768-wallpaper.jpg")),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              primaryThemeTextWidget(context, widget.carType),
                              primaryTextNormal(context, widget.carName),
                              primaryThemeTextNormal(context, widget.carNumber)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: Wrap (
                                    direction: Axis.vertical,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.airline_seat_recline_normal, color: Colors.blue,),
                                                primaryTextSmall(context, DemoLocalizations.of(context)?.getText("seats")),
                                              ],
                                            ),
                                            const SizedBox(width: 5,),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                primaryThemeTextWidget(context, widget.numberOfSeatsAvailable.toString()),
                                                primaryTextSmall(context, DemoLocalizations.of(context)?.getText("available")),
                                              ],
                                            ),
                                            const SizedBox(width: 5,),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                primaryThemeTextWidget(context, widget.numberOfSeatsOffered.toString()),
                                                primaryTextSmall(context, DemoLocalizations.of(context)?.getText("offered")),
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
                                    secondaryTextSmall(context, DemoLocalizations.of(context)?.getText("set_default")),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: FlutterSwitch(
                                        activeColor: Colors.blue,
                                        width: 70.0,
                                        height: 30.0,
                                        valueFontSize: 10.0,
                                        toggleSize: 20.0,
                                        value: widget.defaultStatus,
                                        borderRadius: 30.0,
                                        padding: 8.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          setState(() {
                                            log("Switch value $val");
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
          ],
        ),
      ),
    );
  }
}
