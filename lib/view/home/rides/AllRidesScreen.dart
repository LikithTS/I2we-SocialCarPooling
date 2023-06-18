import 'dart:async';
import 'dart:developer';

import 'package:common/network/model/AllRidesNewModel.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/RidePaginationApi.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/AllRidesCard.dart';
import 'package:socialcarpooling/view/home/rides/all_rides_start_page.dart';
import '../../../util/Localization.dart';
import '../../../widgets/aleart_widgets.dart';
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
  int end = 10;
  final _streamController = StreamController<List<AllRidesNewModel>>();
  late ScrollController _scrollController;
  List<AllRidesNewModel>? allRideList;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && end != ridesCount) {
        start = end + 1;
        end = end + 10;
        if(end > ridesCount) {
          end = ridesCount;
        }
        log("New end page $end");
        if (end <= ridesCount) {
          showSnackBarByTime(context, "Loading more items");
          rideRepository
              .getRidesBasedOnType(
              RidePaginationApi(start: start.toString(), end: end.toString()),
              widget.api)
              .then((response) => _streamController.add(response));
        }
      }
    });
    rideRepository
        .getRidesBasedOnType(
            RidePaginationApi(start: start.toString(), end: end.toString()),
            widget.api)
        .then((response) => _streamController.add(response));
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
              child: StreamBuilder<List<AllRidesNewModel>>(
                stream: _streamController.stream,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (allRideList == null) {
                      allRideList = snapshot.data;
                    } else {
                      List<AllRidesNewModel>? newRideList = snapshot.data;
                      if (newRideList != null &&
                          newRideList.first.drivers != null) {
                        allRideList!.first.drivers!
                            .addAll(newRideList.first.drivers!);
                      }

                      if (newRideList != null &&
                          newRideList.first.passengers != null) {
                        allRideList!.first.passengers!
                            .addAll(newRideList.first.passengers!);
                      }
                    }
                    ridesCount = allRideList?.last.count! ?? 0;
                    if (allRideList != null &&
                        widget.rideType == "Driver" &&
                        allRideList?.first.drivers != null &&
                        allRideList!.first.drivers!.isNotEmpty) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: allRideList!.first.drivers!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return AllRidesCard(
                              rideId:
                                  allRideList!.first.drivers![index].id ?? "",
                              carIcon: 'assets/images/car_pool.png',
                              startAddress: allRideList!.first.drivers![index]
                                      .startDestinationFormattedAddress ??
                                  "",
                              endAddress: allRideList!.first.drivers![index]
                                      .endDestinationFormattedAddress ??
                                  "",
                              dateTime: getDateTimeFormatter().parse(
                                  allRideList!
                                      .first.drivers![index].startTime!),
                              carType: "",
                              amountPerSeat: allRideList!
                                      .first.drivers![index].amountPerSeat ??
                                  0,
                              rideType: widget.rideType);
                        },
                      );
                    } else if (allRideList != null &&
                        widget.rideType == "Passenger" &&
                        allRideList!.first.passengers != null &&
                        allRideList!.first.passengers!.isNotEmpty) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: allRideList!.first.passengers!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return AllRidesCard(
                              rideId:
                                  allRideList!.first.passengers![index].id ??
                                      "",
                              carIcon: 'assets/images/car_pool.png',
                              startAddress: allRideList!
                                      .first
                                      .passengers![index]
                                      .startDestinationFormattedAddress ??
                                  "",
                              endAddress: allRideList!.first.passengers![index]
                                      .endDestinationFormattedAddress ??
                                  "",
                              dateTime: getDateTimeFormatter().parse(
                                  allRideList!
                                      .first.passengers![index].startTime!),
                              carType: allRideList!.first.passengers![index]
                                      .carTypeInterested ??
                                  "",
                              amountPerSeat: -1,
                              rideType: widget.rideType);
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
