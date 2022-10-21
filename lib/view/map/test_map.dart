import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:provider/provider.dart';

/*const LatLng SOURCE_LOCATION = LatLng(13.0714, 80.2417);
const LatLng DEST_LOCATION = LatLng(13.0569, 80.2425);*/
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

  Set<Marker> _markers = Set();

  LatLng? sourceLocation;
  LatLng? destinationLocation;

  List<LatLng> polylineCoordinates = [];

  Set<Polyline> allPolylinesByPosition = {};

  LocationData? currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set up initial location
    this.getCurrentLocation();
    //this.setInitLocation();

    this.setSourceAndDestMakerIcon();
    this.getPolyPoints();
    //set up makers icons
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) => {currentLocation = location});
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
        'AIzaSyDYorBkcy6CwXJQZjAmv0_2EJyAQMFwQNM',
        PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
        PointLatLng(destinationLocation!.latitude, destinationLocation!.longitude));

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
     *//* sourceLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);*//*
  }*/

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      sourceLocation = Provider.of<AddressProvider>(context,listen: false).driverStartLatLng;
      print('Source Data'+sourceLocation!.latitude.toString()+" Source Data ${sourceLocation!.longitude.toString()}");
      destinationLocation = Provider.of<AddressProvider>(context,listen: false).driverDestLatLng;
      print('Dest Data'+sourceLocation!.latitude.toString()+" Dest Data ${sourceLocation!.longitude.toString()}");

    });
    return Scaffold(
      body: currentLocation == null
          ? Center(child: Text('Loading'),)
          : Stack(
              children: [
                Container(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: false,
                    markers: _markers,
                    mapType: MapType.terrain,
                    initialCameraPosition:  CameraPosition(
                        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                        zoom: CAMERA_ZOOM,
                        tilt: CAMERA_TILT,
                        bearing: CAMERA_BEARING),
                    polylines: allPolylinesByPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      showPinOnMap();
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void showPinOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('CurrentPin'),
          position:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          icon: currentIcon!));
      _markers.add(Marker(
          markerId: MarkerId('SourcePin'),
          position: sourceLocation!,
          icon: sourceIcon!));
      _markers.add(Marker(
          markerId: MarkerId('DestinationPin'),
          position: destinationLocation!,
          icon: destinationIcon!));
    });
  }
}
