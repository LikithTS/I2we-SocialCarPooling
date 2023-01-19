import 'dart:developer';

import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/CurrentRideApi.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/my_ride_routes_view.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_start_page.dart';

import '../../../util/constant.dart';

class MyRidesRoutesScreen extends StatefulWidget {
  final String rideId;
  final String rideType;

  const MyRidesRoutesScreen({
    Key? key,
    required this.rideId,
    required this.rideType,
  }) : super(key: key);

  @override
  State<MyRidesRoutesScreen> createState() => _MyRidesRoutesScreen();
}

class _MyRidesRoutesScreen extends State<MyRidesRoutesScreen> {
  RideRepository rideRepository = RideRepository();

  @override
  Widget build(BuildContext context) {
    CurrentRideApi currentRideApi =
        CurrentRideApi(rideType: widget.rideType, rideId: widget.rideId);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<dynamic>(
                future: rideRepository.getCurrentRide(api: currentRideApi),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    UpcomingRides? upcomingRide = snapshot.data;
                    if (upcomingRide != null) {
                      return MyRideRoutesView(
                        rideId: upcomingRide.id ?? "",
                        carIcon: 'assets/images/car_pool.png',
                        startAddress:
                            upcomingRide.startDestinationFormattedAddress ?? "",
                        endAddress:
                            upcomingRide.endDestinationFormattedAddress ?? "",
                        rideType: widget.rideType,
                        amount: upcomingRide.amountPerSeat ?? 0,
                        dateTime: getDateTimeFormatter()
                            .parse(upcomingRide.startTime!),
                        seatsOffered: upcomingRide.seatsOffered ?? 1,
                        carType: upcomingRide.carTypeInterested ?? "",
                        coRidersCount: upcomingRide.riderCount ?? 0,
                        leftButtonText:
                            upcomingRide.riderStatus ?? Constant.RIDE_CANCELLED,
                        rideStatus:
                            upcomingRide.riderStatus ?? Constant.RIDE_CREATED,
                        startLocation:
                            upcomingRide.startLocation ?? StartLocation(),
                        endLocation:
                            upcomingRide.endLocation ?? StartLocation(),
                        refreshScreen: () => refreshScreen(),
                        travelledPassengers: upcomingRide.travelPassengers ?? List.empty(),
                        driverRide: upcomingRide.driverRide,
                        invites: upcomingRide.invites ?? List.empty(),
                      );
                    }
                  }
                  return const MyRidesStartPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  refreshScreen() {
    // Refresh home screen data
    setState(() {
      log("Refresh move screen data");
    });
  }
}
