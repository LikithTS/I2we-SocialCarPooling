import 'dart:developer';

import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_start_page.dart';

import '../../../util/constant.dart';
import '../../../util/Localization.dart';
import '../../../widgets/widget_text.dart';
import 'my_rides_card.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({Key? key}) : super(key: key);

  @override
  State<MyRidesScreen> createState() => _MyRidesScreen();
}

class _MyRidesScreen extends State<MyRidesScreen> {
  RideRepository rideRepository = RideRepository();
  late Future<List<dynamic>> future;

  @override
  void initState() {
    future = rideRepository.getUpcomingRides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      headerText(
                          DemoLocalizations.of(context)?.getText("my_rides") ??
                              "")
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.group),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text('1'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: future,
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
                          log("Travel partner passenger ${upcomingRideList[index].travelPassengers}");
                          log("Travel partner driver ${upcomingRideList[index].driverRide}");
                          return MyRides(
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
                            invites:
                                upcomingRideList[index].invites ?? List.empty(),
                            travelledPassengers:
                                upcomingRideList[index].travelPassengers ??
                                    List.empty(),
                            driverRide: upcomingRideList[index].driverRide,
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
    future = rideRepository.getUpcomingRides();
    setState(() {
      log("Refresh move screen data");
    });
  }
}
