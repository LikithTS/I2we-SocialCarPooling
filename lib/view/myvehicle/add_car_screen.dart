import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/color.dart';
import '../../utils/Localization.dart';
import '../../utils/widget_functions.dart';
import '../../widgets/button_widgets.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => AddCarScreenState();
}

class AddCarScreenState extends State<AddCarScreen> {
  var set_default = false;
  var is_electric_vehicle = false;
  String offeringState = "offering_seats";
  String availableState = "available_seats";
  List<Color> availableSeatsColor = [];
  List<Color> offeringSeatsColor = [];
  List<Color> availableSeatsTextColor = [];
  List<Color> offeringSeatsTextColor = [];
  @override
  void initState() {
    super.initState();
    setDefaultColors();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      headerText(DemoLocalizations.of(context)
                              ?.getText("my_cars_title") ??
                          "")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      smallText(
                          DemoLocalizations.of(context)
                                  ?.getText("car_info_desc") ??
                              "",
                          Alignment.topLeft),
                      addVerticalSpace(20),
                      CircleAvatar(
                        radius: 58,
                        backgroundImage: const NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                        child: Stack(children: const [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white70,
                              child: Icon(Icons.photo_camera),
                            ),
                          ),
                        ]),
                      ),
                      addVerticalSpace(20),
                      buildMaterialForm(
                          context,
                          DemoLocalizations.of(context)?.getText("car_name") ??
                              "",
                          Icons.drive_eta,
                          Icons.edit),
                      addVerticalSpace(10),
                      buildMaterialForm(
                          context,
                          DemoLocalizations.of(context)
                                  ?.getText("register_number") ??
                              "",
                          Icons.text_snippet,
                          Icons.edit),
                      addVerticalSpace(10),
                      buildMaterialForm(
                          context,
                          DemoLocalizations.of(context)?.getText("car_type") ??
                              "",
                          Icons.drive_eta,
                          Icons.arrow_drop_down),
                      addVerticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
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
                                      value: set_default,
                                      onChanged: (value) {
                                        setState(() {
                                          set_default = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                smallText(
                                    DemoLocalizations.of(context)
                                            ?.getText("electric_vehicle") ??
                                        "",
                                    Alignment.topLeft),
                                Container(
                                  width: 40,
                                  height: 30,
                                  child: Container(
                                    width: 30,
                                    height: 20,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: CupertinoSwitch(
                                        value: is_electric_vehicle,
                                        onChanged: (value) {
                                          setState(() {
                                            is_electric_vehicle = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      addVerticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.airline_seat_recline_normal,
                              color: primaryLightColor),
                          smallText(
                              DemoLocalizations.of(context)
                                      ?.getText("available_seats") ??
                                  "",
                              Alignment.topLeft)
                        ],
                      ),
                      addVerticalSpace(10),
                      FittedBox(
                        child: Row(
                          children: [
                            buildslectionElevatedButton(
                                1,
                                availableSeatsColor[0],
                                availableSeatsTextColor[0],
                                availableState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                2,
                                availableSeatsColor[1],
                                availableSeatsTextColor[1],
                                availableState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                3,
                                availableSeatsColor[2],
                                availableSeatsTextColor[2],
                                availableState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                4,
                                availableSeatsColor[3],
                                availableSeatsTextColor[3],
                                availableState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                5,
                                availableSeatsColor[4],
                                availableSeatsTextColor[4],
                                availableState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                6,
                                availableSeatsColor[5],
                                availableSeatsTextColor[5],
                                availableState),
                          ],
                        ),
                      ),
                      addVerticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.airline_seat_recline_normal,
                              color: primaryLightColor),
                          smallText(
                              DemoLocalizations.of(context)
                                      ?.getText("offering_seats") ??
                                  "",
                              Alignment.topLeft)
                        ],
                      ),
                      addVerticalSpace(10),
                      FittedBox(
                        child: Row(
                          children: [
                            buildslectionElevatedButton(
                                1,
                                offeringSeatsColor[0],
                                offeringSeatsTextColor[0],
                                offeringState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                2,
                                offeringSeatsColor[1],
                                offeringSeatsTextColor[1],
                                offeringState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                3,
                                offeringSeatsColor[2],
                                offeringSeatsTextColor[2],
                                offeringState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                4,
                                offeringSeatsColor[3],
                                offeringSeatsTextColor[3],
                                offeringState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                5,
                                offeringSeatsColor[4],
                                offeringSeatsTextColor[4],
                                offeringState),
                            const SizedBox(
                              width: 20,
                              child: Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                            ),
                            buildslectionElevatedButton(
                                6,
                                offeringSeatsColor[5],
                                offeringSeatsTextColor[5],
                                offeringState),
                          ],
                        ),
                      ),
                      addVerticalSpace(10),
                      Material(
                        elevation: 2.0,
                        child: TextFormField(
                          readOnly: true,
                          showCursor: true,
                          cursorWidth: 0,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: DemoLocalizations.of(context)
                                    ?.getText("upload_document") ??
                                "",
                            hintText: DemoLocalizations.of(context)
                                ?.getText("add_photos"),
                            labelStyle: const TextStyle(color: hintColor),
                            hintStyle:
                                const TextStyle(color: primaryLightColor),
                            prefixIcon: const Icon(Icons.newspaper,
                                color: primaryLightColor),
                            suffixIcon: const Icon(
                              Icons.add_circle_outline,
                              color: primaryLightColor,
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(20),
                      Material(
                        elevation: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                addVerticalSpace(10),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: primaryLightColor,
                                  ),
                                ),
                                smallText(
                                    DemoLocalizations.of(context)
                                            ?.getText("upload_car_images") ??
                                        "",
                                    Alignment.topLeft)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/login_image.png",
                                        width: 45.w,
                                        height: 54.h,
                                        fit: BoxFit.fill),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: size.width,
                          child: primaryButtonWithCallBack(
                              DemoLocalizations.of(context)?.getText("done") ??
                                  "",
                              addCar),
                        ),
                      ),
                      addVerticalSpace(20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material buildMaterialForm(BuildContext context, String labelText,
      IconData prefixIcon, IconData suffixIcon) {
    return Material(
      elevation: 2.0,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: primaryLightColor),
          suffixIcon: Icon(
            suffixIcon,
            color: primaryLightColor,
          ),
        ),
      ),
    );
  }

  Widget buildslectionElevatedButton(
      int number, Color bgColor, Color textColor, String state) {
    return SizedBox(
      width: 100,
      height: 100,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ElevatedButton(
          onPressed: () {
            changeColor(state, number);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor:
                MaterialStateProperty.all(bgColor), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return primaryLightColor;
              } // <-- Splash color
            }),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              number.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  void addCar() {}

  void setDefaultColors() {
    for (int i = 0; i <= 6; i++) {
      availableSeatsColor.add(Colors.white);
      availableSeatsTextColor.add(primaryColor);
      offeringSeatsColor.add(Colors.white);
      offeringSeatsTextColor.add(primaryColor);
    }
  }

  void setDefaultOfferColorsBeforeUpdate() {
    for (int i = 0; i <= 5; i++) {
      offeringSeatsColor[i] = Colors.white;
      offeringSeatsTextColor[i] = primaryColor;
    }
  }

  void setDefaultAvailableColorsBeforeUpdate() {
    for (int i = 0; i <= 5; i++) {
      availableSeatsColor[i] = Colors.white;
      availableSeatsTextColor[i] = primaryColor;
    }
  }

  void changeColor(String state, int position) {
    setState(() {
      if (state == offeringState) {
        setDefaultOfferColorsBeforeUpdate();
        for (int i = 0; i < position; i++) {
          offeringSeatsColor[i] = primaryColor;
          offeringSeatsTextColor[i] = Colors.white;
        }
      } else {
        setDefaultAvailableColorsBeforeUpdate();
        for (int i = 0; i < position; i++) {
          availableSeatsColor[i] = primaryColor;
          availableSeatsTextColor[i] = Colors.white;
        }
      }
    });
  }
}
