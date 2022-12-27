import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../util/configuration.dart';
import '../../font&margin/margin_confiq.dart';

class LocationGet extends StatefulWidget {
  const LocationGet({Key? key}) : super(key: key);

  @override
  State<LocationGet> createState() => _LocationGetState();
}

class _LocationGetState extends State<LocationGet> {
  GoogleMapController? mapController;
  double? latitude;
  double? longitude;
  late LatLng currentPosition;
  var _initialCameraPosition =
      CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 14);

  final Set<Marker> _markers = {};

  void getLocation() async {
    Position position = await getGeoLocationCoOrdinates();
    var places = await GeocodingPlatform.instance.placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en");
    _initialCameraPosition = CameraPosition(
        target: LatLng(latitude ?? 0.0, longitude ?? 0.0), zoom: 14);
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;

      _markers.add(Marker(
        draggable: true,
        markerId: MarkerId("marker_1"),
        position: LatLng(latitude!, longitude!),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: 'Orgin',
        ),
      ));
    });
  }

  Future<Position> getGeoLocationCoOrdinates() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Services are not enabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are not enabled');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are denied permanently');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void onMoveCamera() async {
    LatLngBounds bounds = await mapController!.getVisibleRegion();
    final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    _markers.clear();

    var places = await GeocodingPlatform.instance
        .placemarkFromCoordinates(lat, lon, localeIdentifier: "en");

    setState(() {
      _markers.add(Marker(
        draggable: true,
        markerId: MarkerId("marker_2"),
        position: LatLng(lat, lon),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title:
              '${places[0].street} , ${places[0].locality}, ${places[0].postalCode}',
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      latitude == null && longitude == null
          ? Container(
              width: deviceWidth(context),
              height: deviceHeight(context),
              child: Container(
                width: margin50,
                height: margin50,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : GoogleMap(
              mapType: MapType.terrain,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude!, longitude!),
                zoom: 14,
              ),
              markers: _markers,
              onCameraIdle: () => onMoveCamera(),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
      /*  Align(
          alignment: Alignment.center,
          child: Transform.translate(
              offset: Offset(0, -34),
              child: Icon(
                Icons.location_on,
                size: 44,
              )))*/
    ]));
  }
}
