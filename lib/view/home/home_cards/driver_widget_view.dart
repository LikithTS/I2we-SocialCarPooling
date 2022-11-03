import 'dart:developer';

import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/StartDestination.dart';
import 'package:common/network/request/newRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/model/direction.dart';
import 'package:socialcarpooling/model/steps.dart' as directionSteps;
import 'package:common/network/request/Steps.dart' as requestSteps;
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/CPSessionManager.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/view/home/home_cards/date_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/time_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_icon_text_form_click.dart';
import 'package:socialcarpooling/widgets/alert_dialog_with_ok_button.dart';

import '../../../buttons/elevated_full_width_button_view.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';

class DriverWidgetView extends StatefulWidget {
  const DriverWidgetView({Key? key}) : super(key: key);

  @override
  State<DriverWidgetView> createState() => HomeDriverState();
}

class HomeDriverState extends State<DriverWidgetView> {
  var originValue = TextEditingController();
  var destinationValue = TextEditingController();
  var timeValue = TextEditingController();
  var dateValue = TextEditingController();
  var seatOffered = TextEditingController();
  var rideAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width;
    Provider.of<DriverProvider>(context, listen: false).changeDriver(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          addVerticalSpace(5),
          HomeTextIconFormClick(
            hint: DemoLocalizations.of(context)!.getText("start_address"),
            prefixIcon: Icons.my_location,
            userType: 'driver',
            flagAddress: true,
            addressValue: originValue,
          ),
          addVerticalSpace(12),
          HomeTextIconFormClick(
            hint: DemoLocalizations.of(context)!.getText("destination_address"),
            prefixIcon: Icons.location_on,
            userType: 'driver',
            flagAddress: false,
            addressValue: destinationValue,
          ),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 5,
                  child: TimeSelectionWithHintSupport(
                    text: DemoLocalizations.of(context)!.getText("time"),
                    iconData: Icons.schedule,
                    timerValue: timeValue,
                  )),
              addHorizontalSpace(12),
              Expanded(
                  flex: 5,
                  child: DateSelectionWithHintSupport(
                    text: DemoLocalizations.of(context)!.getText("date"),
                    iconData: Icons.calendar_today,
                    reqDateValue: dateValue,
                  )),
            ],
          ),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 5,
                child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("seats_offered"),
                  iconData: Icons.airline_seat_recline_extra,
                  isNumber: true,
                  updatedValue: seatOffered,
                ),
              ),
              addHorizontalSpace(12),
              Expanded(
                flex: 5,
                child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("amount"),
                  iconData: Icons.currency_rupee,
                  isNumber: true,
                  updatedValue: rideAmount,
                ),
              ),
            ],
          ),
          addVerticalSpace(10),
          elevatedDynamicWidthButtonView(
              DemoLocalizations.of(context)?.getText("post_ride"),
              width,
              onPostRideButtonClicked)
        ],
      ),
    );
  }

  void onPostRideButtonClicked() {
    log("Button clicked post ride");
    log("Start Address ${originValue.text.isEmpty}");
    log("End Address ${destinationValue.text.isEmpty}");
    log("Drive start time ${timeValue.text.isEmpty}");
    log("Drive start date ${dateValue.text.isEmpty}");
    log("Seats offered ${seatOffered.text.isEmpty}");
    log("Ride amount ${rideAmount.text.isEmpty}");

    log("Direction data lat ${CPSessionManager()
        .getDirectionObject()
        .routes![0].legs![0].startLocation!.lat}");
    log("Direction data long ${CPSessionManager()
        .getDirectionObject()
        .routes![0].legs![0].startLocation!.lng}");

    if (originValue.text.isEmpty ||
        destinationValue.text.isEmpty ||
        timeValue.text.isEmpty ||
        dateValue.text.isEmpty ||
        seatOffered.text.isEmpty ||
        rideAmount.text.isEmpty) {
      alertDialogView(context, "post_ride_error");
    } else {
      final DateTime utcRideStartTime = DateFormat("yyyy-MM-dd hh:mm aaa")
          .parse('${dateValue.text} ${timeValue.text}', true);
      log("UTC date ${utcRideStartTime.toIso8601String()}");
      final Direction directionObject = CPSessionManager().getDirectionObject();
      StartDestination origin = StartDestination(
          formattedAddress: directionObject.routes![0].legs![0].startAddress,
          placeId: directionObject.geocodedWaypoints![1].placeId,
          lat: directionObject.routes![0].legs![0].startLocation!.lat
              .toString(),
          long: directionObject.routes![0].legs![0].startLocation!.lng
              .toString()
      );
      StartDestination destination = StartDestination(
          formattedAddress: directionObject.routes![0].legs![0].endAddress,
          placeId: directionObject.geocodedWaypoints![0].placeId,
          lat: directionObject.routes![0].legs![0].endLocation!.lat.toString(),
          long: directionObject.routes![0].legs![0].endLocation!.lng.toString()
      );
      final String? distance = directionObject.routes![0].legs![0].distance
          ?.text;
      final String? duration = directionObject.routes![0].legs![0].duration
          ?.text;
      final List<directionSteps.Steps>? steps = directionObject.routes![0]
          .legs![0].steps;
      List<requestSteps.Steps>? reqSteps = [];
      if (steps != null) {
        for (var step in steps) {
          reqSteps.add(requestSteps.Steps(distanceInMeters: step.distance?.value,
              lat: step.endLocation?.lat.toString(),
              long: step.endLocation?.lng.toString()));
        }
      }
      NewRideApi api = NewRideApi(
        startDestination: origin,
        endDestination: destination,
        rideType: Constant.AS_HOST,
        startTime: utcRideStartTime.toIso8601String(),
        seatsOffered: int.parse(seatOffered.text),
        amountPerSeat: int.parse(rideAmount.text),
        distance: distance,
        duration: duration,
        steps: reqSteps
      );
      log("New Ride API $api");
      RideRepository rideRepository = RideRepository();
      Future<dynamic> future = rideRepository.postNewRide(api: api);
      future.then((value) => {handleResponseData(value)});
    }
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
      log("Post new ride successful");
      alertDialogView(context, "ride_created_successful");
    }
  }
}
