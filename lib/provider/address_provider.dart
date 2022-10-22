import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressProvider extends ChangeNotifier {
  String address = '';
  String startDriverAddress = '';
  String endDriverAddress = '';
  String startRiderAddress = '';
  String endRiderAddress = '';
  LatLng latLng=LatLng(0.0, 0.0);
  LatLng driverStartLatLng=LatLng(0.0, 0.0);
  LatLng driverDestLatLng=LatLng(0.0, 0.0);

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
  changeLatLng(LatLng newLatLng) {
    latLng = newLatLng;
    notifyListeners();
  }

  changeDriverStartLatLong(LatLng newLatLng) {
    driverStartLatLng = newLatLng;
    notifyListeners();
  }
  changeDriverDestLatLong(LatLng newLatLng) {
    driverDestLatLng = newLatLng;
    notifyListeners();
  }
}
