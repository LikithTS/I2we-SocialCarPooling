import 'package:common/network/exception/ApiException.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/HistoryApiRespository.dart';
import 'package:common/network/response/HistoryResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/home_cards/recent_rides_card.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../util/CPString.dart';
import '../../utils/Localization.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/circular_progress_loader.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  bool isRideDataAvailable = false;
  bool isDataLoading = true;
  HistoryResponse? _historyResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(CPString.HISTORY)),
        body: getHistoryWidget());
  }

  @override
  void initState() {
    super.initState();
    fetchHistoryData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchHistoryData() {
    HistoryApiRepository()
        .getAllRides()
        .then((value) => handleHistoryResponseData(value))
        .catchError((onError) {
      handleErrorResponseData(onError);
    });
  }

  void updateHistoryData(HistoryResponse value) {
    setState(() {
      _historyResponse = value;
      if (value.rides?.isNotEmpty == true) {
        isRideDataAvailable = true;
      } else {
        isRideDataAvailable = false;
      }
    });
  }

  void handleHistoryResponseData(value) {
    isDataLoading = false;
    if (value is HistoryResponse) {
      updateHistoryData(value);
    } else if (value is ErrorResponse) {
      showSnackbar(context, value.errorMessage ?? "");
    }
  }

  void handleErrorResponseData(onError) {
    if (onError is ApiException) {
      showSnackbar(context, onError.errorResponse.errorMessage ?? "");
    }
  }

  Widget getAllRideWidget(BuildContext context) {
    int _totalcount = (_historyResponse?.rides?.length ?? 0);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        itemCount: _totalcount,
        itemBuilder: (BuildContext buildContext1, int index1) {
          return getRecentRideWidget(index1);
        });
  }

  getRecentRideWidget(int index) {
    List<RideData>? recentRides = _historyResponse?.rides;
    if (index < (recentRides?.length ?? 0)) {
      RideData recentRide = recentRides![index];
      return RecentRidesWidget(
        carIcon: 'assets/images/car_pool.png',
        startAddress: recentRide.startDestinationFormattedAddress ?? "",
        endAddress: recentRide.endDestinationFormattedAddress ?? "",
        rideType: recentRide.rideType ?? "",
        amount: recentRide.amountPerSeat ?? 0,
        dateTime: DateTime.parse(recentRide.startTime ?? ""),
        seatsOffered: recentRide.seatsOffered ?? 1,
        carType: recentRide.carTypeInterested ?? "",
        coRidersCount: "",
        leftButtonText: "",
        rideStatus: recentRide.rideStatus ?? recentRide.riderStatus?? "",
        isDisplayTitle: false
      );
    } else {
      return Container();
    }
  }

  Widget getNoRideWidget(BuildContext context) {
    TextStyle textStyle =
        TextStyleUtils.primaryTextLight.copyWith(fontSize: fontSize17);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(StringUrl.history_no_ride),
                addVerticalSpace(28),
                Text(CPString.NO_RIDES_AVAILABLE, style: textStyle)
              ]),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 45.0),
              child: secondaryButton(
                  DemoLocalizations.of(context)
                          ?.getText("post_a_ride_button") ??
                      "", () {
                Navigator.pop(context);
              }),
            ))
      ],
    ));
  }

  Widget getHistoryWidget() {
    if (isDataLoading) {
      return getLoadingWidget();
    } else if (isRideDataAvailable) {
      return getAllRideWidget(context);
    } else {
      return getNoRideWidget(context);
    }
  }
}
