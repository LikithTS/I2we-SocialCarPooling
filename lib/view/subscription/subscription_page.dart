import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/widgets/text_widgets.dart';
import 'package:socialcarpooling/widgets/widget_text.dart';

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
        body: getSubscriptionWidget());
  }

  getSubscriptionWidget() {
    final Size size = MediaQuery.of(context).size;
      return Scaffold(
        body: Column(
          children: [
            addVerticalSpace(20),
            SvgPicture.asset(StringUrl.subscription_image),
            addVerticalSpace(25),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: primaryTextBoldWidgetLeft(
                  context,
                  DemoLocalizations.of(context)
                      ?.getText("subscription_title") ??
                      "Benefits Includes"),
            ),
            addVerticalSpace(30),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/star.png',
                        width: 30, height: 30, fit: BoxFit.cover),
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Column(
                      children: [
                        primaryTextBoldWidgetLeft(context, DemoLocalizations.of(context)
                        ?.getText("subscription_point_one") ??
                        ""),
                        primaryTextNormal(context, DemoLocalizations.of(context)
                            ?.getText("subscription_point_one_desc") ??
                            ""),
                      ],
                    ),
                  )
                ],
              ),
            ),
            addVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/star.png',
                        width: 30, height: 30, fit: BoxFit.cover),
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Column(
                      children: [
                        primaryTextBoldWidgetLeft(context, DemoLocalizations.of(context)
                            ?.getText("subscription_point_two") ??
                            ""),
                        primaryTextNormal(context, DemoLocalizations.of(context)
                            ?.getText("subscription_point_two_desc") ??
                            ""),
                      ],
                    ),
                  )
                ],
              ),
            ),
            addVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/star.png',
                        width: 30, height: 30, fit: BoxFit.cover),
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Column(
                      children: [
                        primaryTextBoldWidgetLeft(context, DemoLocalizations.of(context)
                            ?.getText("subscription_premium_membership") ??
                            ""),
                        primaryTextNormal(context, DemoLocalizations.of(context)
                            ?.getText("subscription_premium_membership_desc") ??
                            ""),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //Subscription box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    height: 220,
                    width: size.width / 2,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 18.0, left: 10),
                                    child: primaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                        ?.getText("free") ??
                                        "", Colors.white),
                                  ),
                                  addVerticalSpace(20),
                                  Wrap(
                                    crossAxisAlignment:
                                    WrapCrossAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: secondaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                            ?.getText("15_days") ??
                                            "", Colors.white),
                                      ),
                                      addVerticalSpace(20),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: secondaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                            ?.getText("pay_annual_fees_after") ??
                                            "", Colors.white),
                                      ),
                                    ],
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    height: 220,
                    width: size.width / 2,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: primaryLightColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 18.0, left: 10),
                                    child: primaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                        ?.getText("go_pro") ??
                                        "", primaryColor),
                                  ),
                                  addVerticalSpace(20),
                                  Wrap(
                                    crossAxisAlignment:
                                    WrapCrossAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: secondaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                            ?.getText("15_days") ??
                                            "", greyColor),
                                      ),
                                      addVerticalSpace(20),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: secondaryTextBoldWidgetLeftCustomColor(context, DemoLocalizations.of(context)
                                            ?.getText("pay_annual_fees") ??
                                            "", greyColor),
                                      ),
                                    ],
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      );
  }
}
