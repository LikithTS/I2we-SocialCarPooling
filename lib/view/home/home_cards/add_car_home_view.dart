import 'package:flutter/material.dart';
import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';

class AddCarCard extends StatelessWidget {
  const AddCarCard({Key? key}) : super(key: key);

  void addCarButtonClicked() {}

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: primaryTextWidgetLeft(context, DemoLocalizations.of(context)?.getText("my_cars_title")),
            ),
            Card(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/add_car.png'),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              primaryThemeTextWidget(context, DemoLocalizations.of(context)?.getText("host_a_ride")),
                              primaryTextNormal(context,
                                  DemoLocalizations.of(context)?.getText("add_car_details_description")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}