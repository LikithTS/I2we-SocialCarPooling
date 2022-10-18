import 'dart:developer';

import 'package:common/network/repository/HomeRepository.dart';
import 'package:common/network/response/HomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/constant.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_cards/add_car_home_view.dart';
import 'package:socialcarpooling/view/home/home_cards/car_home_view.dart';
import 'package:socialcarpooling/view/home/home_cards/profile_home_card.dart';
import 'package:socialcarpooling/view/home/home_cards/recent_rides_card.dart';
import 'package:socialcarpooling/view/home/home_drawer/navigation_drawer_widget.dart';

import '../../util/color.dart';
import '../../utils/Localization.dart';
import 'home_cards/driver_widget_view.dart';
import 'home_cards/questionnaire_home_card.dart';
import 'home_cards/rider_widget_view.dart';
import 'home_cards/upcoming_rides_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late final TabController tabController;
  HomeRepository homeRepository = HomeRepository();
  late HomeResponse homeResponseData;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    Future<dynamic> future = homeRepository.home();
    future
        .then((value) =>
            {log("Home Response is  $value"), handleHomeResponseData(value)})
        .catchError((onError) {
      log("Home Response error is  $onError");
      // handleErrorResponse(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _key,
            drawer: const NavigationDrawerWidget(),
            body: Container(
              color: Colors.grey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.grey,
                      child: Row(
                        children: [
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              color: Colors.blue,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                _key.currentState?.openDrawer();
                              },
                            ),
                          ),
                          const Spacer(),
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: const Icon(Icons.message),
                              color: Colors.blue,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                            ),
                          ),
                          addHorizontalSpace(10),
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: const Icon(Icons.alarm),
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    minChildSize: 0.5,
                    maxChildSize: 0.9,
                    initialChildSize: 0.5,
                    builder: (BuildContext context,
                        ScrollController myScrollController) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)),
                        child: Container(
                          color: homePageBackgroundColor,
                          child: SingleChildScrollView(
                            controller: myScrollController,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 30),
                                    height: 2,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: TabBar(
                                      unselectedLabelColor: textGreyColor,
                                      unselectedLabelStyle: TextStyle(
                                          color: textGreyColor,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.sp),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20.sp),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                        color: primaryLightColor,
                                        // Other flags
                                        // indicatorRadius: 1,
                                        // insets: EdgeInsets.all(1),
                                        // padding: EdgeInsets.all(10)
                                      ),
                                      controller: tabController,
                                      tabs: [
                                        Text(DemoLocalizations.of(context)!
                                            .getText("driver_tab")),
                                        Text(DemoLocalizations.of(context)!
                                            .getText("rider_tab"))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      height: 320,
                                      child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            showDriverWidget(context),
                                            showRiderWidget(context)
                                          ]),
                                    ),
                                  ),
                                  UpcomingRides(
                                    carIcon: 'assets/images/car_pool.png',
                                    startAddress: homeResponseData.upcomingRides![0].startDestinationFormattedAddress ?? '',
                                    endAddress: "Philips, Manyata",
                                    rideType: Constant.AS_HOST,
                                    amount: 100,
                                    dateTime: DateTime.now(),
                                    seatsOffered: "4",
                                    carType: Constant.CAR_TYPE_SEDAN,
                                    coRidersCount: "2",
                                    leftButtonText: Constant.BUTTON_CANCEL,
                                    rideStatus: Constant.RIDE_SCHEDULED,
                                  ),
                                  RecentRides(
                                    carIcon: 'assets/images/car_pool.png',
                                    startAddress: "Maruthi Nagar",
                                    endAddress: "Philips, Manyata",
                                    rideType: Constant.AS_HOST,
                                    amount: 100,
                                    dateTime: DateTime.now(),
                                    seatsOffered: "4",
                                    carType: Constant.CAR_TYPE_SEDAN,
                                    coRidersCount: "2",
                                    leftButtonText: Constant.BUTTON_CANCEL,
                                    rideStatus: Constant.RIDE_COMPLETED,
                                  ),
                                  const QuestionnaireCard(
                                      questionnairesCompletionPercentage: 0.30),
                                  const ProfileCard(
                                      profileName: "Likith",
                                      profileCompletionPercentage: 0.20),
                                  const HomeCarCard(
                                      carType: Constant.CAR_TYPE_SEDAN,
                                      carName: "Ciaz",
                                      carNumber: "KA05MU2778",
                                      numberOfSeatsOffered: 4,
                                      numberOfSeatsAvailable: 5,
                                      defaultStatus: true),
                                  const AddCarCard()
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  Widget buildNavigationDrawer() => Column(
        children: [
          Text(
            DemoLocalizations.of(context)!.getText("home"),
            style: const TextStyle(color: Colors.blue),
          )
        ],
      );

  handleHomeResponseData(value) {
    homeResponseData = value;
  }
}
