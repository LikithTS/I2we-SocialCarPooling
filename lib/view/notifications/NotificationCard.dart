import 'package:flutter/material.dart';

import '../../util/color.dart';
import '../../widgets/text_widgets.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryColor,
          size: 40,
        ),
        title: notificationTitle(context, title),
        subtitle: Column(
          children: [
            //notificationSubTitle(context, "Requested Ride"),
            notificationSubDesc(context, subtitle),
          ],
        ),
        trailing: Visibility(visible: false, child: Text(time)),
        isThreeLine: true,
      ),
    );
  }
}
