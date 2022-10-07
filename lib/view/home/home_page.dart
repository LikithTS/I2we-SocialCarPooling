import 'package:flutter/material.dart';
import 'package:socialcarpooling/utils/widget_functions.dart';
import 'package:socialcarpooling/view/home/BorderIcon.dart';
import 'package:socialcarpooling/view/home/home_drawer/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _key,
            drawer: const NavigationDrawerWidget(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
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
                    )
                  ],
                ),
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
}
