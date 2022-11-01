import 'package:common/network/exception/ApiException.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/HistoryApiRespository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/widgets/aleart_widgets.dart';

import '../../util/CPString.dart';
import '../../util/font_size.dart';
import '../../utils/Localization.dart';
import '../../widgets/button_widgets.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  bool isRideDataAvailable = false;

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

  void handleHistoryResponseData(value) {
    if(value is ErrorResponse) {
      showSnackbar(context, value.errorMessage ?? "");
    }
  }

  void handleErrorResponseData(onError) {
    if(onError is ApiException) {
      showSnackbar(context, onError.errorResponse.errorMessage ?? "");
    }
  }

  Widget getAllRideWidget(BuildContext context) {
    return Text("");
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
    if (isRideDataAvailable) {
      return getAllRideWidget(context);
    } else {
      return getNoRideWidget(context);
    }
  }
}
