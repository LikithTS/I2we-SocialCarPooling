
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget googleMap(BuildContext context,double latitude,double longitude,_controller) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child:GoogleMap(
      mapType: MapType.terrain,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude), zoom: 15),
      markers: {
        Marker(
            draggable: true,
            markerId: MarkerId('Source'),
            position: LatLng(latitude, longitude))
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ),
  );
}