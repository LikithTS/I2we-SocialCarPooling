import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/response/HomeResponse.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/get_formatted_date_time.dart';

import '../../../util/constant.dart';
import 'add_car_home_view.dart';
import 'car_home_view.dart';
import 'profile_home_card.dart';
import 'questionnaire_home_card.dart';
import 'recent_rides_card.dart';
import 'upcoming_rides_card.dart';

Widget loadHomePageData(HomeResponse data, Function() refreshScreen) {
  if (data.myCars!.isNotEmpty) {
    CPSessionManager().setIfCarDetailsAdded(true);
  } else {
    CPSessionManager().setIfCarDetailsAdded(false);
  }
  return Column(
    children: [
      if (data.upcomingRides != null && data.upcomingRides!.isNotEmpty) ...[
        UpcomingRidesWidget(
          rideId: data.upcomingRides?.firstWhere((element) => true).id ?? "",
          carIcon: 'assets/images/car_pool.png',
          startAddress: data.upcomingRides
                  ?.firstWhere((element) => true)
                  .startDestinationFormattedAddress ??
              "",
          endAddress: data.upcomingRides
                  ?.firstWhere((element) => true)
                  .endDestinationFormattedAddress ??
              "",
          rideType:
              data.upcomingRides?.firstWhere((element) => true).rideType ??
                  Constant.AS_HOST,
          amount:
              data.upcomingRides?.firstWhere((element) => true).amountPerSeat ??
                  0,
          dateTime: getDateTimeFormatter().parse(
              data.upcomingRides?.firstWhere((element) => true).startTime ??
                  ""),
          seatsOffered:
              data.upcomingRides?.firstWhere((element) => true).seatsOffered ??
                  1,
          carType: data.upcomingRides
                  ?.firstWhere((element) => true)
                  .carTypeInterested ??
              Constant.CAR_TYPE_SEDAN,
          coRidersCount:
              data.upcomingRides?.firstWhere((element) => true).riderCount ?? 0,
          leftButtonText:
              data.upcomingRides?.firstWhere((element) => true).rideStatus ??
                  Constant.RIDE_CANCELLED,
          rideStatus:
              data.upcomingRides?.firstWhere((element) => true).rideStatus ??
                  Constant.RIDE_CREATED,
          refreshScreen: refreshScreen,
        ),
      ],
      if (data.recentRides != null && data.recentRides!.isNotEmpty) ...[
        RecentRidesWidget(
          carIcon: 'assets/images/car_pool.png',
          startAddress: data.recentRides
                  ?.firstWhere((element) => true)
                  .startDestinationFormattedAddress ??
              "",
          endAddress: data.recentRides
                  ?.firstWhere((element) => true)
                  .endDestinationFormattedAddress ??
              "",
          rideType: data.recentRides?.firstWhere((element) => true).rideType ??
              Constant.AS_HOST,
          amount:
              data.recentRides?.firstWhere((element) => true).amountPerSeat ??
                  0,
          dateTime: getDateTimeFormatter().parse(
              data.recentRides?.firstWhere((element) => true).startTime ?? ""),
          seatsOffered:
              data.recentRides?.firstWhere((element) => true).seatsOffered ?? 1,
          carType: data.recentRides
                  ?.firstWhere((element) => true)
                  .carTypeInterested ??
              Constant.CAR_TYPE_SEDAN,
          coRidersCount: 0,
          leftButtonText:
              data.recentRides?.firstWhere((element) => true).rideStatus ??
                  Constant.RIDE_CANCELLED,
          rideStatus:
              data.recentRides?.firstWhere((element) => true).rideStatus ??
                  Constant.RIDE_COMPLETED,
        ),
      ],
      if (data.questionnarie?.visibilityStatus ?? false) ...[
        const QuestionnaireCard(questionnairesCompletionPercentage: 0.30),
      ],
      ProfileCard(
          profileName: data.profile?.name ?? "",
          profileCompletionPercentage:
              data.profile?.percentageOfCompletion ?? 100),
      if (data.myCars!.isNotEmpty) ...[
        HomeCarCard(
          carId: data.myCars?.firstWhere((element) => true).id ?? "",
          carType: data.myCars?.firstWhere((element) => true).carType ??
              Constant.CAR_TYPE_MINI,
          carName: data.myCars?.firstWhere((element) => true).carName ?? "",
          carNumber: data.myCars?.firstWhere((element) => true).regNumber ?? "",
          numberOfSeatsOffered:
              data.myCars?.firstWhere((element) => true).offeringSeat ?? 0,
          numberOfSeatsAvailable:
              data.myCars?.firstWhere((element) => true).seatingCapacity ?? 2,
          defaultStatus:
              data.myCars?.firstWhere((element) => true).drivingStatus ?? false,
          carRepository: CarRepository(),
          carImage: data.myCars
                  ?.firstWhere((element) => true)
                  .carPictures?[0] ??
              "https://cdn.pixabay.com/photo/2022/06/02/18/17/car-7238650_1280.png",
        ),
      ] else ...[
        const AddCarCard()
      ]
    ],
  );
}
