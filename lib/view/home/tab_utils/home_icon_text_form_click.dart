import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/provider_preference.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../../provider/address_provider.dart';
import '../../map/location_page.dart';

class HomeTextIconFormClick extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final String userType;
  final bool flagAddress;
  TextEditingController addressValue;

  HomeTextIconFormClick(
      {Key? key,
      required this.hint,
      required this.prefixIcon,
      required this.userType,
      required this.flagAddress,
      required this.addressValue})
      : super(key: key);

  @override
  State<HomeTextIconFormClick> createState() => _HomeTextIconFormClickState();
}

class _HomeTextIconFormClickState extends State<HomeTextIconFormClick> {
  @override
  Widget build(BuildContext context) {
    var startDriverAddress =
        Provider.of<AddressProvider>(context).startDriverAddress;
    var startRiderAddress =
        Provider.of<AddressProvider>(context).startRiderAddress;
    var endDriverAddress =
        Provider.of<AddressProvider>(context).endDriverAddress;
    var endRiderAddress = Provider.of<AddressProvider>(context).endRiderAddress;
    if(widget.flagAddress) {
      if(widget.userType.toString() == 'driver') {
          widget.addressValue.text = startDriverAddress;
      } else {
        widget.addressValue.text = startRiderAddress;
      }
    } else {
      if(widget.userType.toString() == 'driver') {
        widget.addressValue.text = endDriverAddress;
      } else {
        widget.addressValue.text = endRiderAddress;
      }
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        key: Key(widget.addressValue.text),
        initialValue: widget.addressValue.text,
        onTap: () {
          ProviderPreference().putAddress(context, '');
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: LocationPage(
                    flagAddress:widget.flagAddress,
                    userType: widget.userType,
                  )));
        },
        readOnly: true,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: widget.hint,
            hintStyle: const TextStyle(color: greyColor),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.grey,
            )),
      ),
    );
  }
}
