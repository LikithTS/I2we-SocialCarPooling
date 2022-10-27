import 'package:flutter/material.dart';
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
      CameraPosition(target: LatLng(13.0714, 80.2417), zoom: 14);

  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  LatLng? sourceLocation;
  LatLng? destinationLocation;

  DirectionResponse? directionResponse;

  @override
  void dispose() {
    super.dispose();
    _googleMapController.dispose();
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
      sourceLocation = Provider.of<AddressProvider>(context, listen: false)
          .driverStartLatLng;
      destinationLocation =
          Provider.of<AddressProvider>(context, listen: false).driverDestLatLng;
    }
    if (sourceLocation!.latitude != 0.0) {
      _addMarker(sourceLocation!);
    }
    if (destinationLocation!.latitude != 0.0) {
      _addMarker(destinationLocation!);
    }
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Google Map',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          if (_origin != null)
            TextButton(
                onPressed: () => _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: _origin!.position, zoom: 14.5, tilt: 50.0))),
                style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: TextStyle(fontWeight: FontWeight.w600),
                ),
                child: Text('ORIGIN')),
          if (_destination != null)
            TextButton(
                onPressed: () => _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: _destination!.position,
                        zoom: 14.5,
                        tilt: 50.0))),
                style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: TextStyle(fontWeight: FontWeight.w600),
                ),
                child: Text('DEST')),
        ],
      ),*/
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                if (_origin != null) _origin!,
                if (_destination != null) _destination!,
              },
              polylines: {
                if (directionResponse != null)
                  Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.blueAccent,
                      width: 5,
                      points: directionResponse!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList())
              },
              //onLongPress: _addMarker,
            ),
          ),
          if (directionResponse != null)
            Positioned(
                top: 40,
                child: Container(
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
                  child: Text(
                    '${directionResponse!.totalDistance},${directionResponse!.totalDuration}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            directionResponse != null
                ? CameraUpdate.newLatLngBounds(directionResponse!.bounds, 100)
                : CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: Icon(Icons.gps_fixed),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
            markerId: MarkerId('orgin'),
            infoWindow: InfoWindow(title: 'Orgin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue),
            position: pos);
        _destination = null;
        directionResponse = null;
      });
    } else {
      setState(() {
        _destination = Marker(
            markerId: MarkerId('destination'),
            infoWindow: InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos);
      });

      final directions = await DirectionApiRepository().getDirection(
          origin: _origin!.position, destination: _destination!.position);
      setState(() => directionResponse = directions);
    }
  }
}
