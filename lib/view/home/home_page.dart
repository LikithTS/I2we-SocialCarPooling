import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_drawer/navigation_drawer_widget.dart';
import 'package:socialcarpooling/view/home/tab_utils/bubble_tab_indicator.dart';
import 'package:socialcarpooling/view/home/tab_utils/home_text_form.dart';

import '../../util/color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _key,
            drawer: const NavigationDrawerWidget(),
            body: Container(
              color: Colors.grey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.grey,
                      child: Row(
                        children: [
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: Icon(Icons.menu),
                              color: Colors.blue,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                _key.currentState?.openDrawer();
                              },
                            ),
                          ),
                          Spacer(),
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: Icon(Icons.message),
                              color: Colors.blue,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                            ),
                          ),
                          addHorizontalSpace(10),
                          BorderIcon(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: Icon(Icons.alarm),
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    minChildSize: 0.5,
                    maxChildSize: 0.9,
                    initialChildSize: 0.5,
                    builder: (BuildContext context,
                        ScrollController myScrollController) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)),
                        child: Container(
                          color: Color(0xfff7f7f9),
                          child: SingleChildScrollView(
                            controller: myScrollController,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 30),
                                    height: 2,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                  ),
                                  TabBar(
                                    unselectedLabelColor: Colors.black,
                                    unselectedLabelStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 20.sp),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 20.sp),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: const BubbleTabIndicator(
                                      indicatorHeight: 40.0,
                                      indicatorColor: primaryLightColor,
                                      indicatorRadius: 2,
                                      tabBarIndicatorSize:
                                          TabBarIndicatorSize.tab,
                                      // Other flags
                                      // indicatorRadius: 1,
                                      // insets: EdgeInsets.all(1),
                                      // padding: EdgeInsets.all(10)
                                    ),
                                    controller: tabController,
                                    tabs: const [
                                      Text('As Driver'),
                                      Text(
                                        'As Rider',
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 700,
                                    child: TabBarView(
                                        controller: tabController,
                                        children: [
                                          showDriverWidget(),
                                          showRiderWidget()
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  Widget buildNavigationDrawer() => Column(
        children: [
          Text(
            "Home",
            style: TextStyle(color: Colors.blue),
          )
        ],
      );

  Widget showDriverWidget() {
    return Column(
      children: [
        addVerticalSpace(10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTextIconForm(
              hint: "Enter start address", prefixIcon: Icons.my_location),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTextIconForm(
              hint: "Enter destination address", prefixIcon: Icons.location_on),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textformwithhint(text: "Time", iconData: Icons.schedule),
            textformwithhint(text: "Date", iconData: Icons.calendar_today),
          ],
        ),
        addVerticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textformwithhint(
                text: "Offering Seats",
                iconData: Icons.airline_seat_recline_extra),
            textformwithhint(
                text: "Amount per seat", iconData: Icons.currency_rupee),
          ],
        )
      ],
    );
  }

  Widget showRiderWidget() {
    return Column(
      children: [
        addVerticalSpace(10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTextIconForm(
              hint: "Start point", prefixIcon: Icons.my_location),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTextIconForm(
              hint: "Enter destination address", prefixIcon: Icons.location_on),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeTextIconForm(
              hint: "preffered car type ", prefixIcon: Icons.drive_eta),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textformwithhint(text: "Time", iconData: Icons.schedule),
            textformwithhint(text: "Date", iconData: Icons.calendar_today),
          ],
        ),
        addVerticalSpace(10),
      ],
    );
  }
}

class textformwithhint extends StatelessWidget {
  final String text;
  final IconData iconData;
  const textformwithhint({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ]),
      child: TextFormField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            fillColor: Colors.grey,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.transparent),
            ),
            hintText: text,
            prefixIcon: Icon(
              iconData,
              color: primaryLightColor,
            )),
      ),
    );
  }
}
