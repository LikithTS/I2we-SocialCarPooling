import 'package:common/utils/CPSessionManager.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinRidePassengerCard extends StatefulWidget {
  final String profileImage;
  final String name;
  final String designation;
  final String rideStatus;
  final String phoneNumber;
  final VoidCallback refreshScreen;

  const JoinRidePassengerCard(
      {Key? key,
      required this.name,
      required this.phoneNumber,
      required this.designation,
      required this.profileImage,
      required this.rideStatus,
      required this.refreshScreen})
      : super(key: key);

  @override
  State<JoinRidePassengerCard> createState() => _JoinRidePassengerCard();
}

class _JoinRidePassengerCard extends State<JoinRidePassengerCard> {

  bool _hasCallSupport = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Card(
              child: Container(
            width: screenWidth * 0.90,
            margin: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: lightGreyColor,
                                backgroundImage: NetworkImage(CPSessionManager()
                                        .getImage(widget.profileImage) ??
                                    "")),
                            const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.verified_user_rounded,
                                  color: primaryColor,
                                ))
                          ],
                        ),
                        addHorizontalSpace(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyleUtils.primaryTextSemiBold
                                  .copyWith(color: primaryColor),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.designation,
                                  style: TextStyleUtils.primaryTextRegular
                                      .copyWith(fontSize: 12),
                                  textAlign: TextAlign.start,
                                )),
                          ],
                        )
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      child: IconButton(
                        onPressed: () {
                          if (_hasCallSupport) {
                            _launched =
                                _makePhoneCall(widget.phoneNumber);
                          }
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ride Status',
                        style: TextStyleUtils.primaryTextRegular.copyWith(
                            fontSize: 13, color: greyColor, height: 1.3),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.rideStatus,
                        style: TextStyleUtils.primaryTextRegular.copyWith(
                            fontSize: 13, color: Colors.green, height: 1.3),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                FutureBuilder<void>(
                    future: _launched, builder: _launchStatus),
              ],
            ),
          )),
        ],
      ),
    ));
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}
