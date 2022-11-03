

import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/response/HomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/CPSessionManager.dart';

import '../../../util/constant.dart';
import 'add_car_home_view.dart';
import 'car_home_view.dart';
import 'profile_home_card.dart';
import 'questionnaire_home_card.dart';
import 'recent_rides_card.dart';
import 'upcoming_rides_card.dart';

Widget loadHomePageData(HomeResponse data) {
  if(data.myCars!.isNotEmpty) {
    CPSessionManager().setIfCarDetailsAdded(true);
  } else {
    CPSessionManager().setIfCarDetailsAdded(false);
  }
  return Column(
    children: [
      UpcomingRidesWidget(
        carIcon: 'assets/images/car_pool.png',
        startAddress: data.upcomingRides?.firstWhere((element) => true).startDestinationFormattedAddress ?? "",
        endAddress: data.upcomingRides?.firstWhere((element) => true).endDestinationFormattedAddress ?? "",
        rideType:  data.upcomingRides?.firstWhere((element) => true).rideType ?? Constant.AS_HOST,
        amount: data.upcomingRides?.firstWhere((element) => true).amountPerSeat ?? 0,
        dateTime: DateTime.now(),
        seatsOffered: data.upcomingRides?.firstWhere((element) => true).seatsOffered ?? 1,
        carType: data.upcomingRides?.firstWhere((element) => true).carTypeInterested ?? Constant.CAR_TYPE_SEDAN,
        coRidersCount: "2",
        leftButtonText: Constant.BUTTON_CANCEL,
        rideStatus: Constant.RIDE_SCHEDULED,
      ),
      RecentRidesWidget(
        carIcon: 'assets/images/car_pool.png',
        startAddress: data.recentRides?.firstWhere((element) => true).startDestinationFormattedAddress ?? "",
        endAddress: data.recentRides?.firstWhere((element) => true).endDestinationFormattedAddress ?? "",
        rideType: data.recentRides?.firstWhere((element) => true).rideType ?? Constant.AS_HOST,
        amount: data.recentRides?.firstWhere((element) => true).amountPerSeat ?? 0,
        dateTime: DateTime.now(),
        seatsOffered: data.recentRides?.firstWhere((element) => true).seatsOffered ?? 1,
        carType: Constant.CAR_TYPE_SEDAN,
        coRidersCount: "2",
        leftButtonText: Constant.BUTTON_CANCEL,
        rideStatus: Constant.RIDE_COMPLETED,
      ),
      if (data.questionnarie?.visibilityStatus ?? false) ...[
        const QuestionnaireCard(
            questionnairesCompletionPercentage: 0.30),
      ],
      ProfileCard(
          profileName: data.profile?.name ?? "",
          profileCompletionPercentage: data.profile?.percentageOfCompletion ??  100),
      if(data.myCars!.isNotEmpty) ...[
        HomeCarCard(
            carId: data.myCars?.firstWhere((element) => true).id ?? "",
            carType: data.myCars?.firstWhere((element) => true).carType ?? Constant.CAR_TYPE_MINI,
            carName: data.myCars?.firstWhere((element) => true).carName ?? "",
            carNumber: data.myCars?.firstWhere((element) => true).regNumber ?? "",
            numberOfSeatsOffered: data.myCars?.firstWhere((element) => true).offeringSeat ?? 2,
            numberOfSeatsAvailable: data.myCars?.firstWhere((element) => true).seatingCapacity ?? 2,
            defaultStatus: data.myCars?.firstWhere((element) => true).drivingStatus ?? false,
            carRepository: CarRepository(),),
      ] else ... [
        const AddCarCard()
      ]
    ],
  );
}