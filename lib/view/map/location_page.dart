import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as currentLocation;
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';

import '../../provider/provider_preference.dart';
import '../../util/CPString.dart';
import '../../font&margin/margin_confiq.dart';

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
  late currentLocation.LocationData currentPosition;
  Set<Marker> _markers = {};
  currentLocation.Location location = currentLocation.Location();
  LatLng initialCameraPosition = const LatLng(12.9716, 12.9716);
  var searchedAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("Inside init state of location");
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<AddressProvider>(context).address;
    log("Address in location page $address");
    var latLngProvider = Provider.of<AddressProvider>(context).latLng;
    List<String> result = address.split(',');
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
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : googleMap(context, initialCameraPosition),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: deviceWidth(context) * .75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white, blurRadius: 2.0, spreadRadius: 0.4)
                      ]),
                  child: placesAutoCompleteTextField(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(top: 15, bottom: 200),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10)),
                  child: const Icon(
                    Icons.my_location,
                    color: greyColor,
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
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  width: deviceWidth(context),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
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
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(margin10),
                            ),
                            elevation: margin2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              CPString.confirmLocation,
                              style: TextStyle(fontSize: fontSize18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.center,
                child: Transform.translate(
                    offset: const Offset(0, -34),
                    child: const Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 44,
                    )))
          ],
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    log("Calling get current location co-ordinates");

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

    currentPosition = await location.getLocation();
    log("Current latitude ${currentPosition.latitude}");
    log("Current longitude ${currentPosition.longitude}");
    _getAddressFromLatLng(currentPosition.latitude!, currentPosition.longitude!);

  }

  Future<void> _getAddressFromLatLng(double lat, double lang) async {
    await placemarkFromCoordinates(
        lat, lang)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      var address =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

      setState(() {
        latitude = lat;
        longitude = lang;
        initialCameraPosition = LatLng(lat,lang);
        Provider.of<AddressProvider>(context, listen: false)
            .changeLatLng(
            LatLng(latitude ?? 0.0, longitude ?? 0.0));
        ProviderPreference().putAddress(context, address);
        ProviderPreference().putLatLng(context, LatLng(latitude!, longitude!));
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude!, longitude!), zoom: 15),
          ),
        );
      });

    }).catchError((e) {
      debugPrint(e);
    });
  }

  Widget googleMap(BuildContext context, LatLng latLng) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition:
            CameraPosition(target: initialCameraPosition, zoom: 14),
        markers: _markers,
        onCameraIdle: onMoveCamera,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
    );
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    mapController = googleMapController;
  }

  @override
  void dispose() {
    super.dispose();
    if (mapController != null) {
      mapController!.dispose();
    }
  }

  void onMoveCamera() async {
    LatLngBounds bounds = await mapController!.getVisibleRegion();
    final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    log("OnMove camera lat $lat");
    log("OnMove camera long $lon");

    if (lat != latitude && lon != longitude) {
      _markers.clear();
      _getAddressFromLatLng(lat, lon);
    }
  }

  placesAutoCompleteTextField() {

    var apiKey = CPString.androidApiKey;
    if (Platform.isIOS) {
      apiKey = CPString.iosApiKey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: searchedAddressController,
          googleAPIKey: apiKey,
          inputDecoration: const InputDecoration(hintText: "Search location"),
          debounceTime: 1200,
          countries: const ["in"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: _PlaceDetailsPrediction,
          itmClick: _ClickPrediction
      ),
    );
  }

  void _PlaceDetailsPrediction(Prediction prediction) {
      log("Places details lat ${prediction.lat?.toString()}");
      log("Places details lng ${prediction.lng?.toString()}");
      if(prediction.lat != null && prediction.lng != null) {
        setState((){
          FocusManager.instance.primaryFocus?.unfocus();
          latitude = double.parse(prediction.lat!);
          longitude = double.parse(prediction.lng!);
          initialCameraPosition = LatLng(latitude!,longitude!);
          Provider.of<AddressProvider>(context, listen: false)
              .changeLatLng(LatLng(latitude ?? 0.0, longitude ?? 0.0));
          ProviderPreference().putLatLng(context, LatLng(latitude!,longitude!));
          mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(latitude!, longitude!), zoom: 15),
            ),
          );
        });
      }

  }

  void _ClickPrediction(Prediction prediction) {
      if(prediction.description != null) {
        log("Click Prediction data ${prediction.description}");
        searchedAddressController.text = prediction.description!;
        searchedAddressController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
        ProviderPreference().putAddress(context, prediction.description);
      }
  }

}
