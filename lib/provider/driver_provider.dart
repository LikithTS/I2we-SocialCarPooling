import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverProvider extends ChangeNotifier {

  bool driverFlag = false;
  changeDriver(bool newDiverFlag)
  {
    driverFlag = newDiverFlag;
    notifyListeners();
  }

}
