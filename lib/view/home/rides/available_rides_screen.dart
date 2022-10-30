import 'package:flutter/material.dart';

import '../../../util/constant.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import 'available_rides_card.dart';

class AvailableRidesScreen extends StatelessWidget {
  const AvailableRidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
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
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return AvailableRides(
                        profileImage: "",
                        carIcon: 'assets/images/car_pool.png',
                        startAddress: "Manyata",
                        endAddress: "Yelahanka",
                        rideType: "host",
                        amount: 20,
                        dateTime: DateTime.now(),
                        seatsOffered: 4,
                        carType: "SEDAN",
                        coRidersCount: "2",
                        leftButtonText: Constant.BUTTON_CANCEL,
                        rideStatus: Constant.RIDE_SCHEDULED,
                      );
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
}
