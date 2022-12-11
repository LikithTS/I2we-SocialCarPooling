import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import 'my_rides_card.dart';


class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    RideRepository rideRepository = RideRepository();

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
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.group),
                      ),
                      Positioned(
                        right:0,child:  CircleAvatar(
                        radius: 10,backgroundColor: Colors.red,
                        child: Text('1'),
                      ),)

                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: rideRepository.getUpcomingRides(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<UpcomingRides> upcomingRideList = snapshot.data;
                    return PageView.builder(
                      itemCount: upcomingRideList.length,
                      itemBuilder: (context, index) {
                        return MyRides(
                          carIcon: 'assets/images/car_pool.png',
                          startAddress: upcomingRideList[index].startDestinationFormattedAddress ?? "",
                          endAddress: upcomingRideList[index].endDestinationFormattedAddress ?? "",
                          rideType: upcomingRideList[index].rideType ?? "",
                          amount: upcomingRideList[index].amountPerSeat ?? 0,
                          dateTime: getDateTimeFormatter().parse(upcomingRideList[index].startTime!),
                          seatsOffered: upcomingRideList[index].seatsOffered ?? 1,
                          carType: upcomingRideList[index].carTypeInterested ?? "",
                          coRidersCount: "2",
                          leftButtonText: Constant.BUTTON_CANCEL,
                          rideStatus: upcomingRideList[index].rideStatus ?? "",
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
