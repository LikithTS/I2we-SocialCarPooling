import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/model/direction.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/view/map/location_service_api/direction_api.dart';
import 'package:provider/provider.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
  CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 12);

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
  Direction? directionResponse;
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
    getGpsLocation();
  }

  @override
  Widget build(BuildContext context) {
    var driverFlag = Provider.of<DriverProvider>(context).driverFlag;

    if (driverFlag) {
      sourceLocation =
          Provider.of<AddressProvider>(context, listen: false).riderStartLatLng;
      destinationLocation =
          Provider.of<AddressProvider>(context, listen: false).riderDestLatLng;
    } else {
      sourceLocation = Provider.of<AddressProvider>(context, listen: false).driverStartLatLng;
      destinationLocation =
          Provider.of<AddressProvider>(context, listen: false).driverDestLatLng;
    }
    if (sourceLocation!.latitude != 0.0) {
      _addSourceMarker(sourceLocation!);
    }
    if (destinationLocation!.latitude != 0.0) {
      _addDestMarker(destinationLocation!);
    }

    if(sourceLocation!.latitude!= 0.0 && destinationLocation!.latitude != 0.0)
      {
        _addPolyLine(sourceLocation,destinationLocation);
        print("Source : $sourceLocation : Dest : $destinationLocation");
       // _createPolylines(sourceLocation!.latitude,sourceLocation!.longitude,destinationLocation!.latitude,destinationLocation!.longitude);
      }

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
              if (currentLocation != null) currentLocation!,
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },

            polylines:Set<Polyline>.of(polylines.values),
            //onLongPress: _addMarker,
          ),
          totalDistance!=null&& totalDistance!=null?
            Positioned(
                top: 40,
                child:Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ]),
                  child:Text(
                      '$totalDistance,$totalDuration',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )):Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => getGpsLocation(),
        child: Icon(Icons.gps_fixed),
      ),
    );
  }


   void _addSourceMarker(LatLng pos) async {

      setState(() {
        _origin = Marker(
            markerId: MarkerId('orgin'),
            infoWindow: InfoWindow(title: 'Orgin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue),
            position: pos);
        _destination = null;
      });

  }
   void _addDestMarker(LatLng pos) async {
     setState(() {
        _destination = Marker(
            markerId: MarkerId('destination'),
            infoWindow: InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue),
            position: pos);

      });

  }

  void _addPolyLine(_origin,_destination) async
  {
    final directions = await DirectionApiRepository().getDirection(
        origin: _origin, destination: _destination);
    polylineCoordinates.clear();
    setState(() {
      for (var element in directions.routes!) {
        bounds = LatLngBounds(
          southwest: LatLng(element.bounds!.southwest!.lat!, element.bounds!.southwest!.lng!),
          northeast: LatLng(element.bounds!.northeast!.lat!, element.bounds!.northeast!.lng!),);
        polylinePoints= PolylinePoints().decodePolyline(element.overviewPolyline!.points!);
       for (var point in polylinePoints!) {
         polylineCoordinates.add(LatLng(point.latitude, point.longitude));

         totalDuration= element.legs![0].duration!.text;
         totalDistance= element.legs![0].distance!.text;

       }
        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color:Colors.blueAccent,
          points: polylineCoordinates,
          width: 5,
        );

        setState(() {
          polylines[id] = polyline;
        });
      }

    });
  }


  void getGpsLocation() async {
    Position position = await getGeoLocationCoOrdinates();
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      // on below line we have given positions of Location 5
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 12,
        )));

    setState(() {

      currentLocation = Marker(
          markerId: MarkerId('currentLocation'),
          infoWindow: InfoWindow(title: 'Current Location'),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(position.latitude,position.longitude));
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
