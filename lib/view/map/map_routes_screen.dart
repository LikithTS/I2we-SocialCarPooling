import 'dart:developer';

import 'package:common/network/model/StartLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/view/map/location_service_api/direction_api.dart';
import 'package:provider/provider.dart';

class MapRouteScreen extends StatefulWidget {
  final bool? gpsIconShow;
  final StartLocation? startLocation;
  final StartLocation? endLocation;

  const MapRouteScreen(
      {Key? key, this.gpsIconShow, this.startLocation, this.endLocation})
      : super(key: key);

  @override
  State<MapRouteScreen> createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {

  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? currentLocation;
  Marker? _destination;
  LatLng? sourceLocation;
  LatLng? destinationLocation;
  LatLngBounds? bounds;
  PolylineId? polylineId;
  String? totalDistance;
  String? totalDuration;
  List<PointLatLng>? polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    sourceLocation = LatLng(widget.startLocation?.coordinates?.last ?? 0.0,
        widget.startLocation?.coordinates?.first ?? 0.0);
    _addSourceMarker(sourceLocation!);
    destinationLocation = LatLng(widget.endLocation?.coordinates?.last ?? 0.0,
        widget.endLocation?.coordinates?.first ?? 0.0);
    _addDestMarker(destinationLocation!);
    _addPolyLine(sourceLocation, destinationLocation);
    CameraPosition _initialCameraPosition = CameraPosition(
        target: LatLng(widget.startLocation?.coordinates?.last ?? 12.9716,
            widget.startLocation?.coordinates?.first ?? 77.5946),
        zoom: 12);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },

            polylines: Set<Polyline>.of(polylines.values),
            //onLongPress: _addMarker,
          ),
          totalDistance != null && totalDistance != null
              ? Positioned(
                  top: 40,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0)
                        ]),
                    child: Text(
                      '$totalDistance,$totalDuration',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }

  void _addSourceMarker(LatLng pos) async {
    setState(() {
      _origin = Marker(
          markerId: MarkerId('orgin'),
          infoWindow: InfoWindow(title: 'Orgin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos);
      _destination = null;
    });
  }

  void _addDestMarker(LatLng pos) async {
    setState(() {
      _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos);
    });
  }

  void _addPolyLine(_origin, _destination) async {
    final directions = await DirectionApiRepository()
        .getDirection(origin: _origin, destination: _destination);
    polylineCoordinates.clear();
    setState(() {
      for (var element in directions.routes!) {
        bounds = LatLngBounds(
          southwest: LatLng(
              element.bounds!.southwest!.lat!, element.bounds!.southwest!.lng!),
          northeast: LatLng(
              element.bounds!.northeast!.lat!, element.bounds!.northeast!.lng!),
        );
        polylinePoints =
            PolylinePoints().decodePolyline(element.overviewPolyline!.points!);
        for (var point in polylinePoints!) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));

          totalDuration = element.legs![0].duration!.text;
          totalDistance = element.legs![0].distance!.text;
        }
        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 5,
        );

        setState(() {
          polylines[id] = polyline;
        });
      }
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
}
