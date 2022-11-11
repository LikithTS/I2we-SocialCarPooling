import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {

  bool driverFlag = false;
  bool searchDragFlag = false;
  changeDriver(bool newDiverFlag)
  {
    driverFlag = newDiverFlag;
    notifyListeners();
  }
 changeSearchDrag(bool newSearchDragFlag)
  {
    searchDragFlag = newSearchDragFlag;
    notifyListeners();
  }

}
