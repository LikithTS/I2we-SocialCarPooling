import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/constant.dart';

String getRightButtonText(String rideType, String rideStatus) {
  log("Ride type $rideType");
  log("Ride status $rideStatus");
  switch (rideStatus) {
    case Constant.RIDE_CREATED:
      if (rideType == Constant.AS_HOST) {
        return Constant.BUTTON_START;
      } else {
        return Constant.BUTTON_FIND_RIDE;
      }
    case Constant.RIDE_STARTED:
      return Constant.BUTTON_END;
    case Constant.RIDE_COMPLETED:
      return Constant.BUTTON_COMPLETED;
    case Constant.RIDE_CHECKED_IN:
      return Constant.BUTTON_CHECK_OUT;
    case Constant.RIDE_CHECKED_OUT:
      return Constant.BUTTON_COMPLETED;
    case Constant.RIDE_JOINED:
      return Constant.BUTTON_CHECK_IN;
    case Constant.RIDE_CANCELLED:
      return Constant.BUTTON_CANCELLED;
    default:
      return rideStatus;
  }
}

Color getRightButtonBgColor(String rideType, String rideStatus) {
  switch (rideStatus) {
    case Constant.BUTTON_COMPLETED:
      return Colors.green;
    case Constant.BUTTON_CANCELLED:
      return Colors.red;
    default:
      return primaryColor;
  }
}

String? getStatus(String rideStatus, String rideType) {
  switch (rideStatus) {
    case Constant.RIDE_CREATED:
      if (rideType == Constant.AS_HOST) return Constant.RIDE_STARTED;
      break;
    case Constant.RIDE_STARTED:
      return Constant.RIDE_COMPLETED;
    case Constant.RIDE_COMPLETED:
     break;
    case Constant.RIDE_CHECKED_IN:
      return Constant.RIDE_CHECKED_OUT;
    case Constant.RIDE_CHECKED_OUT:
      return Constant.RIDE_COMPLETED;
    case Constant.RIDE_JOINED:
      return Constant.RIDE_CHECKED_IN;
    default:
      return rideStatus;
  }
}
