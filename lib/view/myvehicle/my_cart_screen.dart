import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/util/color.dart';

import '../../utils/Localization.dart';
import '../../utils/widget_functions.dart';
import '../../widgets/text_widgets.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({Key? key}) : super(key: key);

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  Widget build(BuildContext context) {
    final growableList =
        List<int>.generate(10, (int index) => index * index, growable: true);
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  headerText(
                      DemoLocalizations.of(context)?.getText("my_cars") ?? "")
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
// scrollDirection: Axis.horizontal,
                itemCount: growableList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(growableList[index].toString()),
                    direction: DismissDirection.endToStart,
                    background: slideLeftBackground(),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 130,
                      width: double.maxFinite,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 30, // Image radius
                                backgroundImage: NetworkImage(
                                    'http://m.gettywallpapers.com/wp-content/uploads/2021/09/Hulk-Wallpaper.jpg'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: mycarTextWidget(
                                        DemoLocalizations.of(context)
                                                ?.getText("car_type") ??
                                            "",
                                        primaryColor,
                                        18.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: mycarTextWidget(
                                        DemoLocalizations.of(context)
                                                ?.getText("car_name") ??
                                            "",
                                        primaryColor,
                                        10.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: mycarTextWidget(
                                        "KA 05 MR 1234", primaryColor, 11.sp),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        height: 50,
                                        width: 170,
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.drive_eta),
                                                  smallText(
                                                      DemoLocalizations.of(
                                                                  context)
                                                              ?.getText(
                                                                  "seats") ??
                                                          "",
                                                      Alignment.center),
                                                ],
                                              ),
                                              const RotatedBox(
                                                quarterTurns: 1,
                                                child: Divider(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  primaryThemeTextNormal(
                                                      context, "4"),
                                                  smallText(
                                                      DemoLocalizations.of(
                                                                  context)
                                                              ?.getText(
                                                                  "available") ??
                                                          "",
                                                      Alignment.center),
                                                ],
                                              ),
                                              const RotatedBox(
                                                quarterTurns: 1,
                                                child: Divider(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  primaryThemeTextNormal(
                                                      context, "3"),
                                                  smallText(
                                                      DemoLocalizations.of(
                                                                  context)
                                                              ?.getText(
                                                                  "offered") ??
                                                          "",
                                                      Alignment.center)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    smallText(
                                        DemoLocalizations.of(context)
                                                ?.getText("set_default") ??
                                            "",
                                        Alignment.topLeft),
                                    Container(
                                      width: 40,
                                      height: 30,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: CupertinoSwitch(
                                          value: false,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void delete() {}
}

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}
