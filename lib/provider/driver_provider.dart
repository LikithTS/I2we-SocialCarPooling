import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {

  bool driverFlag = false;
  changeDriver(bool newDiverFlag)
  {
    driverFlag = newDiverFlag;
    notifyListeners();
  }

}
