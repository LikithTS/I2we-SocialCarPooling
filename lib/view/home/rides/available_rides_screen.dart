import 'dart:developer';

import 'package:common/network/model/AvailableRideResponse.dart';
import 'package:common/network/repository/RideRespository.dart';
import 'package:common/network/request/AvailableRideApi.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/get_formatted_date_time.dart';
import 'package:socialcarpooling/view/home/rides/available_rides_card.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import 'my_available_start_page.dart';

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
    log("Ride data Type $rideDataType");
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
                      } else if (snapshot.hasData) {
                        List<AvailableRidesResponse> availableRideList =
                            snapshot.data;
                        log("Available ride is screen ${availableRideList.length}");
                        if (availableRideList.isNotEmpty) {
                          return ListView.builder(
                            itemCount: availableRideList.length,
                            itemBuilder: (context, index) {
                              return AvailableRides(
                                profileImage: CPSessionManager().getImage(
                                        availableRideList[index]
                                            .user
                                            ?.profileImage) ??
                                    "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png",
                                carIcon: availableRideList[index]
                                        .car
                                        ?.carPictures?[0] ??
                                    "",
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
                                    availableRideList[index].user?.work ?? "",
                                routeMatch: int.parse((availableRideList[index]
                                    .rideMatchPercentage ?? "0").split('.').first),
                                profileMatch: int.parse((availableRideList[index]
                                        .profileMatchingPercentage ?? "0").split('.').first),
                                carTypeInterested: availableRideList[index]
                                        .carTypeInterested ??
                                    "",
                                rideType: rideDataType,
                                driverRideId: getDriverId(
                                    availableRideList[index].id,
                                    api.rideId,
                                    api.rideType),
                                passengerRideId: getPassengerId(
                                    availableRideList[index].id,
                                    api.rideId,
                                    api.rideType),
                              );
                            },
                          );
                        }
                      }
                      return const MyAvailableStartPage();
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
    log("Compare two string ${rideType.trim().toUpperCase().compareTo(Constant.AS_HOST.trim().toUpperCase())}");
    log("Compare two string 2 ${rideType == Constant.AS_HOST}");
    if (rideType == Constant.AS_HOST) {
      return Constant.AS_RIDER;
    } else {
      return Constant.AS_HOST;
    }
  }

  getDriverId(String? id, String rideId, String rideType) {
    if (rideType == Constant.AS_HOST) {
      return rideId;
    } else {
      return id;
    }
  }

  getPassengerId(String? id, String rideId, String rideType) {
    if (rideType == Constant.AS_RIDER) {
      return rideId;
    } else {
      return id;
    }
  }
}
