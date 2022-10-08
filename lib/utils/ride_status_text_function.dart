import 'package:socialcarpooling/util/constant.dart';


String getRightButtonText(String rideType, String rideStatus) {
  switch (rideStatus) {
    case Constant.RIDE_SCHEDULED:
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
    default:
      return Constant.BUTTON_START;
  }
}
