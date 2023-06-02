import 'package:common/network/exception/ApiException.dart';
import 'package:common/network/model/NotificationDetails.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/NotificationApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';

import '../../util/CPString.dart';
import '../../widgets/aleart_widgets.dart';
import '../../widgets/circular_progress_loader.dart';
import 'NotificationCard.dart';

class NotificationMainScreen extends StatefulWidget {
  const NotificationMainScreen({Key? key}) : super(key: key);

  @override
  State<NotificationMainScreen> createState() => _HistoryState();
}

class _HistoryState extends State<NotificationMainScreen> {
  bool isDataLoading = false;

  bool isNotificationAvailable = false;
  List<NotificationDetails>? _notificationResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(CPString.NOTIFICATIONS)),
        backgroundColor: Colors.white,
        body: geNotificationWidget());
  }

  @override
  void initState() {
    super.initState();
    fetchNotificationData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchNotificationData() {
    NotificationApiRepository()
        .getAllNotifications()
        .then((value) => handleNotificationResponseData(value))
        .catchError((onError) {
      handleErrorResponseData(onError);
    });
  }

  void handleErrorResponseData(onError) {
    if (onError is ApiException) {
      showSnackbar(context, onError.errorResponse.message ?? "");
    }
  }

  void handleNotificationResponseData(value) {
    isDataLoading = false;
    if (value is ErrorResponse) {
      showSnackbar(context, value.error?[0].message ?? value.message ?? "");
    } else if (value is List<NotificationDetails>) {
      updateHistoryData(value);
    }
  }

  void updateHistoryData(List<NotificationDetails> value) {
    setState(() {
      _notificationResponse = value;
      if (value.isNotEmpty) {
        isNotificationAvailable = true;
      } else {
        isNotificationAvailable = false;
      }
    });
  }

  Widget getAllNotificationWidget(BuildContext context) {
    int _totalcount = _notificationResponse?.length ?? 0;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        itemCount: _totalcount,
        itemBuilder: (BuildContext buildContext1, int index) {
          return Dismissible(
              background: slideLeftBackground(),
              direction: DismissDirection.endToStart,
              key: UniqueKey(),
              child: getNotificationWidget(index));
        });
  }

  getNotificationWidget(int index) {
    if (_notificationResponse != null) {
      return NotificationCard(
        icon: Icons.circle_notifications_rounded,
        title: _notificationResponse![index].title ?? "",
        subtitle: _notificationResponse![index].body ?? "",
        time: '',
      );
    }
  }

  Widget getnoNotificationWidget(BuildContext context) {
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
                Text(CPString.NO_NOTIFICATION, style: textStyle)
              ]),
        ),
      ],
    ));
  }

  Widget geNotificationWidget() {
    if (isDataLoading) {
      return getLoadingWidget();
    } else if (isNotificationAvailable) {
      return getAllNotificationWidget(context);
    } else {
      return getnoNotificationWidget(context);
    }
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              Text(
                "Read",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
