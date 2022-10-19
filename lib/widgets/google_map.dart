
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget googleMap(BuildContext context,double latitude,double longitude,_controller) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: latitude == null && longitude == null
        ? Container(
        width: 50,
        height: 50,
        child: Align(alignment:Alignment.center,child: CircularProgressIndicator()))
        : GoogleMap(
      mapType: MapType.terrain,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude), zoom: 15),
      markers: {
        Marker(
            markerId: MarkerId('Source'),
            position: LatLng(latitude, longitude))
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ),
  );
}