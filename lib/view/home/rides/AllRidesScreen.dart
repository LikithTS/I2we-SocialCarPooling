import 'dart:developer';

import 'package:common/network/model/AllRidesNewModel.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RidePaginationApi.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/AllRidesCard.dart';
import 'package:socialcarpooling/view/home/rides/all_rides_start_page.dart';
import '../../../util/Localization.dart';
import '../../../widgets/widget_text.dart';

class AllRidesScreen extends StatefulWidget {
  const AllRidesScreen({Key? key, required this.api, required this.rideType})
      : super(key: key);
  final String api;
  final String rideType;

  @override
  State<AllRidesScreen> createState() => _AllRidesScreen();
}

class _AllRidesScreen extends State<AllRidesScreen> {
  RideRepository rideRepository = RideRepository();
  int ridesCount = 0;
  int start = 0;
  int end = 5;
  late Future<List<dynamic>> future;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    future = rideRepository.getRidesBasedOnType(
        RidePaginationApi(start: start.toString(), end: end.toString()), widget.api);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        log("On Scroll end");
        start = end+1;
        end = end+end;
        log("New start page $start");
        log("New end page $end");
        future = rideRepository.getRidesBasedOnType(
            RidePaginationApi(
                start: start.toString(), end: end.toString()),
            widget.api);
      }
    });
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
                    List<AllRidesNewModel>? allRideList = snapshot.data;
                    log("ALl Rides list passenger ${allRideList?.first.passengers.toString()}");
                    log("ALl Rides list driver ${allRideList?.first.drivers.toString()}");
                    log("ALl Rides list count ${allRideList?.last.count.toString()}");
                    ridesCount = allRideList?.last.count! ?? 0;
                    if (allRideList != null &&
                        widget.rideType == "Driver" &&
                        allRideList.first.drivers != null &&
                        allRideList.first.drivers!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: allRideList.first.drivers!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return AllRidesCard(
                            rideId: allRideList.first.drivers![index].id ?? "",
                            carIcon: 'assets/images/car_pool.png',
                            startAddress: allRideList.first.drivers![index]
                                    .startDestinationFormattedAddress ??
                                "",
                            endAddress: allRideList.first.drivers![index]
                                    .endDestinationFormattedAddress ??
                                "",
                            dateTime: getDateTimeFormatter().parse(
                                allRideList.first.drivers![index].startTime!),
                            carType: "",
                            amountPerSeat: allRideList
                                    .first.drivers![index].amountPerSeat ??
                                0,
                          );
                        },
                      );
                    } else if (allRideList != null &&
                        widget.rideType == "Passenger" &&
                        allRideList.first.passengers != null &&
                        allRideList.first.passengers!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: allRideList.first.passengers!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return AllRidesCard(
                              rideId:
                                  allRideList.first.passengers![index].id ?? "",
                              carIcon: 'assets/images/car_pool.png',
                              startAddress: allRideList.first.passengers![index]
                                      .startDestinationFormattedAddress ??
                                  "",
                              endAddress: allRideList.first.passengers![index]
                                      .endDestinationFormattedAddress ??
                                  "",
                              dateTime: getDateTimeFormatter().parse(allRideList
                                  .first.passengers![index].startTime!),
                              carType: allRideList.first.passengers![index]
                                      .carTypeInterested ??
                                  "",
                              amountPerSeat: -1);
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
