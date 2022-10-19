import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressProvider extends ChangeNotifier {
  String address = '';
  String startDriverAddress = '';
  String endDriverAddress = '';
  String startRiderAddress = '';
  String endRiderAddress = '';
  double lat = 0;
  double lng = 0;

  changeAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }
  changeStartDriverAddress(String newAddress) {
    startDriverAddress = newAddress;
    notifyListeners();
  }
  changeEndDriverAddress(String newAddress) {
    endDriverAddress = newAddress;
    notifyListeners();
  }
  changeStartRiderAddress(String newAddress) {
    startRiderAddress = newAddress;
    notifyListeners();
  }
  changeEndRiderAddress(String newAddress) {
    endRiderAddress = newAddress;
    notifyListeners();
  }
  changeLat(double newLat) {
    lat = newLat;
    notifyListeners();
  }
  changeLong(double newLong) {
    lng = newLong;
    notifyListeners();
  }
}
