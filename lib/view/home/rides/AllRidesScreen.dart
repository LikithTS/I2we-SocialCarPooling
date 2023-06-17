import 'dart:developer';

import 'package:common/network/model/AllRidesModel.dart';
import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RidePaginationApi.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/AllRidesCard.dart';
import 'package:socialcarpooling/view/home/rides/all_rides_start_page.dart';
import 'package:socialcarpooling/view/home/rides/my_rides_start_page.dart';

import '../../../util/constant.dart';
import '../../../util/Localization.dart';
import '../../../widgets/widget_text.dart';
import 'my_rides_card.dart';

class AllRidesScreen extends StatefulWidget {
  const AllRidesScreen({Key? key, required this.api}) : super(key: key);
final String api;
  @override
  State<AllRidesScreen> createState() => _AllRidesScreen();
}

class _AllRidesScreen extends State<AllRidesScreen> {
  RideRepository rideRepository = RideRepository();
  int ridesCount = 0;
  late Future<List<dynamic>> future;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    future = rideRepository.getRidesBasedOnType(RidePaginationApi(start: 0.toString(), end: 5.toString()),widget.api);
/*    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        future = rideRepository.getRidesBasedOnType(RidePaginationApi(start: ridesCount.toString(), end: (ridesCount+2).toString()),widget.api);
    }
  });*/
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
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
                          DemoLocalizations.of(context)?.getText("all_rides") ??
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<AllRidesModel>? allRideList = snapshot.data;
                    log("ALl Rides list $allRideList");
                    if (allRideList != null &&
                        allRideList.isNotEmpty) {
                      ridesCount = allRideList.length;
                      return ListView.builder(
                        itemCount: allRideList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                        //  log("Travel partner passenger ${upcomingRideList[index].travelPassengers}");
                          //log("Travel partner driver ${upcomingRideList[index].driverRide}");
                          return AllRidesCard(
                            rideId: allRideList[index].id ?? "",
                            carIcon: 'assets/images/car_pool.png',
                            startAddress: allRideList[index]
                                .startDestinationFormattedAddress ??
                                "",
                            endAddress: allRideList[index]
                                .endDestinationFormattedAddress ??
                                "",
                            dateTime: getDateTimeFormatter()
                                .parse(allRideList[index].startTime!),

                            carType:
                            allRideList[index].carTypeInterested ?? "",


                          );
                        },
                      );
                    }
                  }
                  return const AllRidesStartPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
