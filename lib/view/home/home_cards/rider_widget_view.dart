
import 'package:flutter/material.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';

import '../../../buttons/elevated_full_width_button_view.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import '../tab_utils/home_icon_text_form.dart';

Widget showRiderWidget(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        addVerticalSpace(10),
        HomeTextIconForm(
            hint: DemoLocalizations.of(context)!.getText("start_address"),
            prefixIcon: Icons.my_location),
        addVerticalSpace(12),
        HomeTextIconForm(
            hint:
            DemoLocalizations.of(context)!.getText("destination_address"),
            prefixIcon: Icons.location_on),
        addVerticalSpace(12),
        HomeTextIconForm(
            hint: DemoLocalizations.of(context)!.getText("car_type"),
            prefixIcon: Icons.drive_eta),
        addVerticalSpace(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("time"),
                  iconData: Icons.schedule),
            ),
            addHorizontalSpace(12),
            Expanded(
              flex: 5,
              child: TextFormWithHintSupport(
                  text: DemoLocalizations.of(context)!.getText("date"),
                  iconData: Icons.calendar_today),
            ),
          ],
        ),
        addVerticalSpace(10),
        elevatedDynamicWidthButtonView(
            DemoLocalizations.of(context)?.getText("find_ride"), width)
      ],
    ),
  );
}