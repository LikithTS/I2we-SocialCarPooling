import 'package:flutter/material.dart';
import '../../../utils/Localization.dart';
import '../../../widgets/text_widgets.dart';

class AddCarCard extends StatelessWidget {
  const AddCarCard({Key? key}) : super(key: key);

  void addCarButtonClicked() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: Card(
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
                      radius: 38,
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
      ),
    );
  }
}
