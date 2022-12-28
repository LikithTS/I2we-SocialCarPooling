import 'dart:developer';

import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/my_ride_routes_view.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_start_page.dart';

import '../../../util/constant.dart';

class MyRidesRoutesScreen extends StatefulWidget {
  const MyRidesRoutesScreen({Key? key}) : super(key: key);

  @override
  State<MyRidesRoutesScreen> createState() => _MyRidesRoutesScreen();
}

class _MyRidesRoutesScreen extends State<MyRidesRoutesScreen> {
  RideRepository rideRepository = RideRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: rideRepository.getUpcomingRides(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<UpcomingRides>? upcomingRideList = snapshot.data;
                    if (upcomingRideList != null &&
                        upcomingRideList.isNotEmpty) {
                      return PageView.builder(
                        itemCount: upcomingRideList.length,
                        itemBuilder: (context, index) {
                          return MyRideRoutesView(
                            rideId: upcomingRideList[index].id ?? "",
                            carIcon: 'assets/images/car_pool.png',
                            startAddress: upcomingRideList[index]
                                    .startDestinationFormattedAddress ??
                                "",
                            endAddress: upcomingRideList[index]
                                    .endDestinationFormattedAddress ??
                                "",
                            rideType: upcomingRideList[index].rideType ?? "",
                            amount: upcomingRideList[index].amountPerSeat ?? 0,
                            dateTime: getDateTimeFormatter()
                                .parse(upcomingRideList[index].startTime!),
                            seatsOffered:
                                upcomingRideList[index].seatsOffered ?? 1,
                            carType:
                                upcomingRideList[index].carTypeInterested ?? "",
                            coRidersCount:
                                upcomingRideList[index].riderCount ?? 0,
                            leftButtonText:
                                upcomingRideList[index].rideStatus ??
                                    Constant.RIDE_CANCELLED,
                            rideStatus: upcomingRideList[index].rideStatus ??
                                Constant.RIDE_CREATED,
                            startLocation:
                                upcomingRideList[index].startLocation ??
                                    StartLocation(),
                            endLocation: upcomingRideList[index].endLocation ??
                                StartLocation(),
                            refreshScreen: () => refreshScreen(),
                          );
                        },
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
