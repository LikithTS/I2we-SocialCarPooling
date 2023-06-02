import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/Localization.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<SubscriptionPage> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(DemoLocalizations.of(context)?.getText("subscription") ??
                "Subscription")),
        body: getFeedbackWidget());
  }

  getFeedbackWidget() {}
}
