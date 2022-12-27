import 'dart:developer';

import 'package:common/model/direction.dart';
import 'package:common/model/legSteps.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/StartDestination.dart';
import 'package:common/network/request/Steps.dart';
import 'package:common/network/request/newRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/InternetChecks.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/view/home/home_cards/date_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/time_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_icon_text_form_click.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';
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
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DriverProvider>(context, listen: false).changeDriver(false);
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
                child: TimeSelectionWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("time"),
                  iconData: Icons.schedule,
                  timerValue: timeValue,
                ),
              ),
              addHorizontalSpace(12),
              Expanded(
                child: DateSelectionWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("date"),
                  iconData: Icons.calendar_today,
                  reqDateValue: dateValue,
                ),
              ),
            ],
          ),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("seats_offered"),
                  iconData: Icons.airline_seat_recline_extra,
                  isNumber: true,
                  updatedValue: seatOffered,
                ),
              ),
              addHorizontalSpace(12),
              Expanded(
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
    InternetChecks.isConnected()
        .then((isAvailable) => {callRideApi(isAvailable)});
  }

  handleResponseData(value) {
    InternetChecks.closeLoadingProgress(context);
    if (value is SuccessResponse) {
      log("Post new ride successful");
      alertDialogView(context, "ride_created_successful");
      setState(() {});
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    }
  }

  callRideApi(bool isAvailable) {
    if (isAvailable) {
      log("Button clicked post ride");
      log("Start Address ${originValue.text.isEmpty}");
      log("End Address ${destinationValue.text.isEmpty}");
      log("Drive start time ${timeValue.text.isEmpty}");
      log("Drive start date ${dateValue.text.isEmpty}");
      log("Seats offered ${seatOffered.text.isEmpty}");
      log("Ride amount ${rideAmount.text.isEmpty}");

      log("Direction data lat ${CPSessionManager().getDirectionObject().routes![0].legs![0].startLocation!.lat}");
      log("Direction data long ${CPSessionManager().getDirectionObject().routes![0].legs![0].startLocation!.lng}");

      if (originValue.text.isEmpty ||
          destinationValue.text.isEmpty ||
          timeValue.text.isEmpty ||
          dateValue.text.isEmpty ||
          seatOffered.text.isEmpty ||
          rideAmount.text.isEmpty) {
        alertDialogView(context, "post_ride_error");
      } else {
        InternetChecks.showLoadingCircle(context);
        final DateTime utcRideStartTime = DateFormat("yyyy-MM-dd hh:mm aaa")
            .parse('${dateValue.text} ${timeValue.text}', true);
        log("UTC date ${utcRideStartTime.toIso8601String()}");
        final Direction directionObject =
            CPSessionManager().getDirectionObject();
        StartDestination origin = StartDestination(
            formattedAddress: directionObject.routes![0].legs![0].startAddress,
            placeId: directionObject.geocodedWaypoints![1].placeId,
            lat: directionObject.routes![0].legs![0].startLocation!.lat
                .toString(),
            long: directionObject.routes![0].legs![0].startLocation!.lng
                .toString());
        StartDestination destination = StartDestination(
            formattedAddress: directionObject.routes![0].legs![0].endAddress,
            placeId: directionObject.geocodedWaypoints![0].placeId,
            lat:
                directionObject.routes![0].legs![0].endLocation!.lat.toString(),
            long: directionObject.routes![0].legs![0].endLocation!.lng
                .toString());
        final String? distance =
            directionObject.routes![0].legs![0].distance?.text;
        final String? duration =
            directionObject.routes![0].legs![0].duration?.text;
        final List<LegSteps>? steps = directionObject.routes![0].legs![0].steps;
        List<RequestSteps>? reqSteps = [];
        if (steps != null) {
          for (var s in steps) {
            reqSteps.add(RequestSteps(
                distanceInMeters: s.distance?.value,
                lat: s.endLocation?.lat.toString(),
                long: s.endLocation?.lng.toString()));
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
            steps: reqSteps);
        log("New Ride API $api");
        RideRepository rideRepository = RideRepository();
        Future<dynamic> future = rideRepository.postNewRide(api: api);
        future.then((value) => {handleResponseData(value)});
      }
    } else {
      showSnackbar(context, "No Internet");
    }
  }
}
