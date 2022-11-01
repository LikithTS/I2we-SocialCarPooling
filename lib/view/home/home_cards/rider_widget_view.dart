
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/home/home_cards/date_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/text_form_with_hint.dart';
import 'package:socialcarpooling/view/home/home_cards/time_selection_with_hint.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_icon_text_form_click.dart';

import '../../../buttons/elevated_full_width_button_view.dart';
import '../../../provider/driver_provider.dart';
import '../../../utils/Localization.dart';
import '../../../utils/widget_functions.dart';
import '../tab_utils/home_icon_text_form.dart';
import 'package:provider/provider.dart';


class RiderWidgetView extends StatefulWidget {

  const RiderWidgetView({Key? key}) : super(key: key);

  @override
  State<RiderWidgetView> createState() => HomeRiderState();
}

class HomeRiderState extends State<RiderWidgetView> {

  var selectedCarType = "Car Type";

  @override
  Widget build(BuildContext context) {
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
          // HomeTextIconForm(
          //     hint: DemoLocalizations.of(context)!.getText("car_type"),
          //     prefixIcon: Icons.drive_eta),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  value: selectedCarType,
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.transparent),
                    ),
                  ),
                  hint: Text(
                    DemoLocalizations.of(context)
                        ?.getText("car_type") ??
                        "",
                    style: TextStyleUtils.primaryTextMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: carTypeList.map((list) {
                    return DropdownMenuItem(
                      value: list.toString(),
                      child: Text(list),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCarType = value.toString();
                    });
                  },
                  icon: SvgPicture.asset(
                    StringUrl.downArrowImage,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
          addVerticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 5,
                child: TimeSelectionWithHintSupport(
                    text: DemoLocalizations.of(context)!.getText("time"),
                    iconData: Icons.schedule),
              ),
              addHorizontalSpace(12),
              Expanded(
                flex: 5,
                child: DateSelectionWithHintSupport(
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
}

 /*onClickStartLocation(context)
{
 *//* Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.leftToRight,
          child:LocationPage()));*//*
}*/