import 'dart:developer';

import 'package:common/network/model/AvailableRideResponse.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/AvailableRideApi.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/available_rides_card.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';

class AvailableRidesScreen extends StatelessWidget {
  final String rideId;
  final String rideType;

  const AvailableRidesScreen(
      {Key? key, required this.rideId, required this.rideType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    RideRepository rideRepository = RideRepository();
    AvailableRideApi api = AvailableRideApi(rideId: rideId, rideType: rideType);
    log("Api Request for available rides $rideId and ride type $rideType");
    String rideDataType = getRideType(rideType);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      headerText(DemoLocalizations.of(context)
                              ?.getText("available_rides") ??
                          "")
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: rideRepository.postAvailableRides(api: api),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        List<AvailableRidesResponse> availableRideList =
                            snapshot.data;
                        log("Available ride is screen ${availableRideList.length}");
                        return ListView.builder(
                          itemCount: availableRideList.length,
                          itemBuilder: (context, index) {
                            return AvailableRides(
                              profileImage: "",
                              carIcon: 'assets/images/car_pool.png',
                              startAddress: availableRideList[index]
                                      .startDestinationFormattedAddress ??
                                  "",
                              endAddress: availableRideList[index]
                                      .endDestinationFormattedAddress ??
                                  "",
                              amount:
                                  availableRideList[index].amountPerSeat ?? 0,
                              dateTime: getDateTimeFormatter()
                                  .parse(availableRideList[index].startTime!),
                              seatsOffered:
                                  availableRideList[index].seatsOffered ?? 1,
                              carType:
                                  availableRideList[index].car?.carType ?? "",
                              name: availableRideList[index].user?.name ?? "",
                              designation:
                                  availableRideList[index].user?.designation ??
                                      "",
                              routeMatch: availableRideList[index]
                                      .rideMatchPercentage?.toInt() ??
                                  0,
                              profileMatch: availableRideList[index]
                                      .profileMatchingPercentage ??
                                  0,
                              carTypeInterested:
                                  availableRideList[index].carTypeInterested ??
                                      "",
                              rideType: rideDataType,
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
        ),
      ),
    );
  }

  String getRideType(String rideType) {
    if(rideType == Constant.AS_HOST) {
      return Constant.AS_RIDER;
    } else {
      return Constant.AS_HOST;
    }
  }
}
