import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/map/search_location_view.dart';
import 'package:socialcarpooling/widgets/button_widgets.dart';

import '../../util/CPString.dart';
import '../../util/font_size.dart';
import '../../util/margin_confiq.dart';
import '../../widgets/google_map.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  double? latitude;
  double? longitude;
  late LatLng currentPosition;

  void getLocation() async {
    Position position = await getGeoLocationCoOrdinates();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      print("Latitude : $latitude : Longitude : $longitude");
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

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            googleMap(context,latitude!,longitude!,_controller),
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
            SearchLocationView(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 15,bottom: 200),
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
                    getLocation();
                  },
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white),
                  width: deviceWidth(context),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('461-A',style: TextStyleUtils.primaryTextBold,),
                            primaryButton('Change',_gotoChangePage)
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text('461-A, H rd homes town, RR nagar, Bengaluru, Karnataka 560098, India',style: TextStyleUtils.primaryTextLight.copyWith(fontSize: 12,color: lightGreyColor,height: 1.3),)),
                      Container(
                        width: deviceWidth(context),
                        height: 70,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                           /* if (_formKey.currentState!.validate()) {
                              _registration(fullNameController.text,mobileNoController.text);
                            }*/
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

  void _gotoChangePage() {
   /* Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomePage()), (Route<dynamic> route) => false);*/
  }
}
