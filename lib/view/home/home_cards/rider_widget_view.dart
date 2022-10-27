
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_icon_text_form_click.dart';
import 'package:socialcarpooling/view/map/location_page.dart';

import '../../../buttons/elevated_full_width_button_view.dart';
import '../../../provider/driver_provider.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import '../tab_utils/home_icon_text_form.dart';
import 'package:provider/provider.dart';


Widget showRiderWidget(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  Provider.of<DriverProvider>(context,
      listen: false)
      .changeDriver(true);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        addVerticalSpace(10),
        HomeTextIconFormClick(
            hint: DemoLocalizations.of(context)!.getText("start_address"),
            prefixIcon: Icons.my_location,userType: 'rider',flagAddress: true,),
        addVerticalSpace(12),
        HomeTextIconFormClick(
            hint:
            DemoLocalizations.of(context)!.getText("destination_address"),
            prefixIcon: Icons.location_on,userType: 'rider',flagAddress: false,),
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

 /*onClickStartLocation(context)
{
 *//* Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.leftToRight,
          child:LocationPage()));*//*
}*/