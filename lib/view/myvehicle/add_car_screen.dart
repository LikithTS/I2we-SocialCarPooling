import 'dart:developer';

import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/request/addCarApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/util/string_url.dart';
import 'package:socialcarpooling/view/myvehicle/all_car_details_screen.dart';
import 'package:socialcarpooling/widgets/alert_dialog_with_ok_button.dart';
import 'package:socialcarpooling/widgets/material_text_form.dart';

import '../../util/color.dart';
import '../../utils/Localization.dart';
import '../../utils/widget_functions.dart';
import '../../widgets/button_widgets.dart';

class AddCarScreen extends StatefulWidget {
  final CarRepository carRepository;

  const AddCarScreen({Key? key, required this.carRepository}) : super(key: key);

  @override
  State<AddCarScreen> createState() => AddCarScreenState();
}

class AddCarScreenState extends State<AddCarScreen> {
  var set_default = false;
  var is_electric_vehicle = false;
  var availableSeats = 0;
  var offeringSeats = 0;
  var selectedCarType = "Car Type";
  String offeringState = "offering_seats";
  String availableState = "available_seats";
  List<Color> availableSeatsColor = [];
  List<Color> offeringSeatsColor = [];
  List<Color> availableSeatsTextColor = [];
  List<Color> offeringSeatsTextColor = [];

  CarRepository get _carRepository => widget.carRepository;

  final carNameController = TextEditingController();
  final carRegNumberController = TextEditingController();
  final carTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setDefaultColors();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    carNameController.dispose();
    carRegNumberController.dispose();
    carTypeController.dispose();
    super.dispose();
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
                addVerticalSpace(10),
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
                          Icons.edit,
                          carNameController),
                      addVerticalSpace(10),
                      buildMaterialForm(
                          context,
                          DemoLocalizations.of(context)
                                  ?.getText("register_number") ??
                              "",
                          Icons.text_snippet,
                          Icons.edit,
                          carRegNumberController),
                      addVerticalSpace(10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedCarType,
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

  Widget buildslectionElevatedButton(
      int number, Color bgColor, Color textColor, String state) {
    return SizedBox(
      width: 100,
      height: 100,
      child: FittedBox(
        fit: BoxFit.contain,
        child: ElevatedButton(
          onPressed: () {
            log("Seats selected $state");
            if (state == "available_seats") {
              availableSeats = number;
            } else {
              offeringSeats = number;
            }
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

  void addCar() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (offeringSeats > availableSeats) {
      alertDialogView(context, "offering_seats_error");
    } else if (selectedCarType == "Car Type") {
      alertDialogView(context, "car_type_error");
    } else {
      addCarApi(
          carRegNumberController.text,
          is_electric_vehicle,
          carNameController.text,
          availableSeats,
          [],
          offeringSeats,
          selectedCarType,
          "");
    }
  }

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

  void addCarApi(
      String registrationNo,
      bool isEv,
      String carName,
      int seatingCapacity,
      List<String> carPictures,
      int offeringSeats,
      String carType,
      String rcPicture) {
    AddCarApi api = AddCarApi(
        regNumber: registrationNo,
        isEv: isEv,
        carName: carName,
        seatingCapacity: seatingCapacity,
        carPicture: carPictures,
        offeringSeats: offeringSeats,
        carType: carType,
        carRcPicture: rcPicture);

    Future<dynamic> future = _carRepository.addNewCar(api: api);
    future.then((value) => {handleResponseData(value)});
  }

  handleResponseData(value) {
    if (value is SuccessResponse) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              content: Text(DemoLocalizations.of(context)
                      ?.getText("add_car_successful") ??
                  ""),
              actions: <Widget>[
                TextButton(
                  child: Text(
                      DemoLocalizations.of(context)?.getText("continue") ?? ""),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: AllCarDetailsPage(
                                carRepository: CarRepository())));
                  },
                ),
              ],
            );
          });
    }
  }
}
