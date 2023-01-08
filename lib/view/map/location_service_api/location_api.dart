import 'dart:async';
import 'dart:developer';

import 'package:common/model/places.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationApi extends ChangeNotifier {
  List<Place> placeList = [];

  var addressController = TextEditingController();

  final _delay = Deley(milliSeconds: 300);

  final _controller = StreamController<List<Place>>.broadcast();

  Stream<List<Place>> get controllerOut =>
      _controller.stream.asBroadcastStream();

  StreamSink<List<Place>> get controllerIn => _controller.sink;

  addPlace(Place place){
    placeList.add(place);
    controllerIn.add(placeList);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  handleSearch(String query) async {
    if (query.length > 6) {
      _delay.run(() async {
        try {
          List<Location> location = await locationFromAddress(query);
          log("Location from type address $location");
          location.forEach((location) async {
            List<Placemark> placeMarks = await GeocodingPlatform.instance.placemarkFromCoordinates(
                location.latitude, location.longitude);
            placeMarks.forEach((placeMaker) {
             addPlace(Place(
                  name: placeMaker.name.toString(),
                  street: placeMaker.street.toString(),
                  locality: placeMaker.locality.toString(),
                  country: placeMaker.country.toString(),latitude:location.latitude,longitude: location.longitude));
            });
          });
        } on Exception catch (e) {
          print("Platform exception in location api "+e.toString());
        }
      });
    }
    else
      {
        placeList.clear();
      }
  }
}

class Deley {
  final int milliSeconds;
  late VoidCallback action;
  Timer _timer = Timer(const Duration(milliseconds: 300), () {});

  Deley({required this.milliSeconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }
}
