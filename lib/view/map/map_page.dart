import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:provider/provider.dart';

import '../../util/configuration.dart';
import '../../util/margin_confiq.dart';

const double CAMERA_ZOOM = 14;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? currentIcon;
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  final Set<Marker> _markers = {};

  LatLng? sourceLocation;
  LatLng? destinationLocation;

  List<LatLng> polylineCoordinates = [];

  Set<Polyline> allPolylinesByPosition = {};

  LatLng? currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set up initial location
    this.getLocation();
    //this.setInitLocation();

    this.setSourceAndDestMakerIcon();
    this.getPolyPoints();
    //set up makers icons
  }

  void getLocation() async {
    Position position = await getGeoLocationCoOrdinates();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
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

  void setSourceAndDestMakerIcon() async {
    currentIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/location_on.png');
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/location_on.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/location_on.png');
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCHgDPkBitY9TLDasjyqQ0EhZGRQqrZp6M',
        PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
        PointLatLng(
            destinationLocation!.latitude, destinationLocation!.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.longitude, point.longitude)));
    }
    allPolylinesByPosition.add(Polyline(
        polylineId: PolylineId(('routes')),
        points: polylineCoordinates,
        visible: true,
        width: 4,
        color: Colors.red));
    setState(() {});
  }

  /* void setInitLocation() {
    Future.delayed(Duration.zero, () async {
      Provider.of<SettingsProvider>(context,
          listen: false)
          .changeLanguage(isLanguageFlag);
    }
     */ /* sourceLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);*/ /*
  }*/

  @override
  Widget build(BuildContext context) {
    sourceLocation = Provider.of<AddressProvider>(context, listen: false).driverStartLatLng;
    destinationLocation = Provider.of<AddressProvider>(context, listen: false).driverDestLatLng;
    print("LatLong Map : $sourceLocation : $destinationLocation");

    return Scaffold(
      body: currentLocation == null
          ? Container(
              width: deviceWidth(context),
              height: deviceHeight(context) * .5,
              child: Container(
                width: margin50,
                height: margin50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  height: deviceHeight(context) * .5,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: false,
                    markers: filterData(),
                    mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude,
                            currentLocation!.longitude),
                        zoom: CAMERA_ZOOM,
                        tilt: CAMERA_TILT,
                        bearing: CAMERA_BEARING),
                    polylines: allPolylinesByPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                     // showPinOnMap();
                    },
                  ),
                ),
              ],
            ),
    );
  }

/*
  void showPinOnMap(LatLng sourceLocation) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('CurrentPin'),
          position:
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
      _markers.add(Marker(
          markerId: MarkerId('SourcePin'),
          position: sourceLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));

    });
  }*/
  Set<Marker> filterData() {
    _markers.clear();

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('CurrentPin'),
          position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
      _markers.add(Marker(
          markerId: MarkerId('SourcePin'),
          position: sourceLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          markerId: MarkerId('DestinationPin'),
          position: destinationLocation!,
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
    });
    return _markers;
  }
}
