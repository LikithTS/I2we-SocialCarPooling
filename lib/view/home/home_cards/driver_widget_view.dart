

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/view/home/home_cards/date_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/time_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_icon_text_form_click.dart';

import '../../../buttons/elevated_full_width_button_view.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import 'package:provider/provider.dart';

class DriverWidgetView extends StatefulWidget {

  const DriverWidgetView({Key? key}) : super(key: key);

  @override
  State<DriverWidgetView> createState() => HomeDriverState();
}

class HomeDriverState extends State<DriverWidgetView> {

  var timeValue = TextEditingController();
  var dateValue = TextEditingController();
  var seatOffered = TextEditingController();
  var rideAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Provider.of<DriverProvider>(context,
        listen: false)
        .changeDriver(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          addVerticalSpace(5),
          HomeTextIconFormClick(
            hint: DemoLocalizations.of(context)!.getText("start_address"),
            prefixIcon: Icons.my_location,userType:'driver',flagAddress: true,),
          addVerticalSpace(12),
          HomeTextIconFormClick(
            hint:
            DemoLocalizations.of(context)!.getText("destination_address"),
            prefixIcon: Icons.location_on,userType:'driver',flagAddress: false,),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 5,
                  child: TimeSelectionWithHintSupport(
                      text: DemoLocalizations.of(context)!.getText("time"),
                      iconData: Icons.schedule, timerValue: timeValue,)),
              addHorizontalSpace(12),
              Expanded(
                  flex: 5,
                  child: DateSelectionWithHintSupport(
                      text: DemoLocalizations.of(context)!.getText("date"),
                      iconData: Icons.calendar_today, reqDateValue: dateValue,)),
            ],
          ),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 5,
                child: TextFormWithHintSupport(
                  text:
                  DemoLocalizations.of(context)!.getText("seats_offered"),
                  iconData: Icons.airline_seat_recline_extra,
                  isNumber: true,
                  updatedValue: seatOffered,),
              ),
              addHorizontalSpace(12),
              Expanded(
                flex: 5,
                child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("amount"),
                  iconData: Icons.currency_rupee,
                  isNumber: true,
                  updatedValue: rideAmount,),
              ),
            ],
          ),
          addVerticalSpace(10),
          elevatedDynamicWidthButtonView(
              DemoLocalizations.of(context)?.getText("post_ride"), width, onPostRideButtonClicked)
        ],
      ),
    );
  }

  void onPostRideButtonClicked() {
    log("Button clicked post ride");
    log("Drive start time ${timeValue.text}");
    log("Drive start date ${dateValue.text}");
    log("Seats offered ${seatOffered.text}");
    log("Ride amount ${rideAmount.text}");
    log("UTC date ${DateFormat("yyyy-MM-dd hh:mm aaa").parse('${dateValue.text} ${timeValue.text}', true)}");
  }

}