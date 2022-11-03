import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/map/search_location_view.dart';

import '../../provider/provider_preference.dart';
import '../../util/CPString.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';

class LocationPage extends StatefulWidget {
  final bool flagAddress;
  final String userType;

  const LocationPage(
      {Key? key, required this.flagAddress, required this.userType})
      : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? mapController;

  double? latitude;
  double? longitude;
  late LatLng currentPosition;
  Set<Marker> _markers = {};

  var _initialCameraPosition =
      CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 16);
  //Don't change this

  void getCurrentLocation() async {
    Position position = await getGeoLocationCoOrdinates();
    getLocation(position.latitude, position.longitude);
  }

  void getLocation(double lat, double lng) async {
    var places = await GeocodingPlatform.instance.placemarkFromCoordinates(
        lat, lng,
        localeIdentifier: "en");
    _initialCameraPosition= CameraPosition(target: LatLng(latitude??0.0, longitude??0.0), zoom: 16);
    mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
            _initialCameraPosition
        )
    );
    setState(() {
      latitude = lat;
      longitude = lng;

      Provider.of<AddressProvider>(context, listen: false)
          .changeLatLng(LatLng(latitude ?? 0.0, longitude ?? 0.0));
      log("Places $places");
      ProviderPreference().putAddress(context,
          '${places[0].name} , ${places[0].street} , ${places[0].locality}, ${places[0].postalCode}');
      _markers.add(Marker(
          markerId: MarkerId('Home'),
          position: LatLng(latitude ?? 0.0, longitude ?? 0.0)));
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

  void searchedAddressData(double latitude, double longitude){
    log("Searched address data callback $latitude and $longitude");
    getLocation(latitude, longitude);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<AddressProvider>(context).address;
    var latLngProvider = Provider.of<AddressProvider>(context).latLng;
    List<String> result = address.split(',');
    _initialCameraPosition = CameraPosition(
        target: LatLng(latitude ?? 0.0, longitude ?? 0.0), zoom: 16);
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
    if (latLngProvider.latitude != 0.0) {
      setState(() {
        _markers.clear();
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            position:
                LatLng(latLngProvider.latitude, latLngProvider.longitude)));
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            latitude == null && longitude == null
                ? Container(
                    width: deviceWidth(context),
                    height: deviceHeight(context),
                    child: Container(
                      width: margin50,
                      height: margin50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : googleMap(context, LatLng(latitude!, longitude!)),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10)),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SearchLocationView(searchedAddressData: searchedAddressData,),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 200),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10)),
                  child: Icon(
                    Icons.my_location,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    getCurrentLocation();
                  },
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  width: deviceWidth(context),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            result[0],
                            style: TextStyleUtils.primaryTextBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            address,
                            style: TextStyleUtils.primaryTextRegular.copyWith(
                                fontSize: 14,
                                color: lightGreyColor,
                                height: 1.3),
                          )),
                      Container(
                        width: deviceWidth(context),
                        height: 70,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.userType.toString() == 'driver'
                                ? Provider.of<DriverProvider>(context,
                                        listen: false)
                                    .changeDriver(false)
                                : Provider.of<DriverProvider>(context,
                                        listen: false)
                                    .changeDriver(true);

                            widget.flagAddress
                                ? widget.userType.toString() == 'driver'
                                    ? ProviderPreference()
                                        .putStartDriverAddress(context, address)
                                    : ProviderPreference()
                                        .putStartRiderAddress(context, address)
                                : widget.userType.toString() == 'driver'
                                    ? ProviderPreference()
                                        .putEndDriverAddress(context, address)
                                    : ProviderPreference()
                                        .putEndRiderAddress(context, address);
                            widget.flagAddress
                                ? widget.userType.toString() == 'driver'
                                    ? ProviderPreference().putDriverStartLatLng(
                                        context, latLngProvider)
                                    : ProviderPreference().putRiderStartLatLng(
                                        context, latLngProvider)
                                : widget.userType.toString() == 'driver'
                                    ? ProviderPreference().putDriverDestLatLng(
                                        context, latLngProvider)
                                    : ProviderPreference().putRiderDestLatLng(
                                        context, latLngProvider);

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(margin10),
                            ),
                            elevation: margin2,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              CPString.confirmLocation,
                              style: TextStyle(fontSize: fontSize18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget googleMap(BuildContext context, LatLng latLng) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }
}
