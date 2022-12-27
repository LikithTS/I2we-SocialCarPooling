import 'package:flutter/material.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';

import '../../../buttons/elevated_button_view.dart';
import '../../../buttons/outline_button_view.dart';
import '../../../util/TextStylesUtil.dart';
import '../../../util/color.dart';
import '../../../util/configuration.dart';
import '../../../utils/Localization.dart';
import '../../../utils/get_formatted_date_time.dart';
import '../../../utils/widget_functions.dart';
import '../../../widgets/card_date_time_view.dart';
import '../../../widgets/ride_type_view.dart';
import '../../../widgets/text_widgets.dart';
import '../../map/map_screen.dart';
import 'my_rides_screen.dart';

class MyRideRoutes extends StatefulWidget {
  const MyRideRoutes({Key? key}) : super(key: key);

  @override
  State<MyRideRoutes> createState() => _MyRideRoutesState();
}

class _MyRideRoutesState extends State<MyRideRoutes> {

  bool showCheckout= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: deviceHeight(context) * .50,
            child: MapScreen(gpsIconShow:false),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.message),
                        ),
                        Positioned(
                          right:0,child:  CircleAvatar(
                          radius: 10,backgroundColor: Colors.red,
                          child: Text('1'),
                        ),)

                      ],
                    ),
                    addHorizontalSpace(10),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.notifications),
                        ),
                        Positioned(
                          right:0,child:  CircleAvatar(
                          radius: 10,backgroundColor: Colors.red,
                          child: Text('1'),
                        ),)

                      ],
                    ),
                    addHorizontalSpace(10),
                  ],
                ),

              ],
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.5,
            maxChildSize: 0.9,
            initialChildSize: 0.5,
            builder: (BuildContext context,
                ScrollController myScrollController) {
              return ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30)),
                child: Container(
                  color: homePageBackgroundColor,
                  child: SingleChildScrollView(
                    controller: myScrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Card(
                              child: Container(
                                width: screenWidth * 0.85,
                                margin: const EdgeInsets.all(5.0),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset('assets/images/car_pool.png',
                                              width: 60, height: 60, fit: BoxFit.cover),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 5, bottom: 5),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.route_rounded),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      primaryThemeTextNormal(
                                                          context,
                                                          DemoLocalizations.of(context)
                                                              ?.getText("from")),
                                                      primaryTextNormalTwoLine(
                                                          context, 'startAddress'),
                                                      primaryThemeTextNormal(
                                                          context,
                                                          DemoLocalizations.of(context)
                                                              ?.getText("to")),
                                                      primaryTextNormalTwoLine(context, 'endAddress'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 5, bottom: 5),
                                            child: Column(
                                              children: [
                                                rideTypeView(DemoLocalizations.of(context)
                                                    ?.getText("as_rider")),
                                                const SizedBox(
                                                  height: 10,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          timeView(Icons.calendar_today_sharp,
                                              'Sat , 21, Nov 2021'),
                                          timeView(Icons.schedule, '9:30 AM'),
                                          timeView(Icons.airline_seat_recline_normal,
                                              'Car type'),
                                        ],
                                      ),
                                    ),

                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5, bottom: 5),
                                      child: Row(
                                        children: [
                                          primaryTextNormalTwoLine(
                                              context,
                                              DemoLocalizations.of(context)
                                                  ?.getText("join_ride_to_see") ??
                                                  ""),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          showCheckout?SizedBox.shrink(): outlineButtonView('CANCEL', () {}),

                                          elevatedButtonView(showCheckout?DemoLocalizations.of(context)?.getText("check_out") ??
                                              "":DemoLocalizations.of(context)?.getText("check_in") ??
                                              "",showCheckout?Colors.red:Color(0Xff1D883A), () {
                                            print("Click");
                                            setState(() {
                                              showCheckout=true;
                                            });
                                          })
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Co-riders',style: TextStyleUtils.primaryTextRegular,textAlign: TextAlign.start,)),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:5,
                              itemBuilder: (context,index){
                                return   Container(
                                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                  child: Column(
                                    children: [
                                      index==0?
                                      Card(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: screenWidth * 0.85,
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
                                                                  backgroundColor: Colors.white,
                                                                  radius: 30,
                                                                  child: Image.asset("assets/images/car_pool.png",width: 60,height: 60,),
                                                                ),
                                                                Positioned(bottom:0,right:0,child: Icon(Icons.verified_user_rounded,color: Colors.green,))
                                                              ],
                                                            ),
                                                            addHorizontalSpace(10),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.route_rounded),
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    primaryThemeTextNormal(
                                                                        context,
                                                                        DemoLocalizations.of(context)
                                                                            ?.getText("from")),
                                                                    primaryTextNormalTwoLine(
                                                                        context, "startAddress"),
                                                                    primaryThemeTextNormal(
                                                                        context,
                                                                        DemoLocalizations.of(context)
                                                                            ?.getText("to")),
                                                                    primaryTextNormalTwoLine(context, "endAddress"),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],

                                                        ),
                                                        Column(
                                                          children: [
                                                            rideTypeView(DemoLocalizations.of(context)
                                                                ?.getText("as_host")),
                                                            addVerticalSpace(10),
                                                            Text('₹ 250',style: TextStyleUtils.primaryTextBold.copyWith(color: Colors.green),),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: const Divider(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.85,
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
                                                                  backgroundColor: primaryColor,
                                                                  radius: 30,
                                                                  child: Icon(Icons.account_circle,color:Colors.white,size: 60,),
                                                                ),
                                                                Positioned(bottom:0,right:0,child: Icon(Icons.verified_user_rounded,color: primaryLightColor,))
                                                              ],
                                                            ),
                                                            addHorizontalSpace(10),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Co-rider name',style: TextStyleUtils.primaryTextSemiBold.copyWith(color: primaryColor),),
                                                                Align(alignment:Alignment.topLeft,child: Text('Designation',style: TextStyleUtils.primaryTextRegular.copyWith(fontSize: 12),textAlign: TextAlign.start,)),
                                                              ],
                                                            )
                                                          ],

                                                        ),
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor: primaryColor,
                                                          child: Icon(Icons.message,size: 20,color: Colors.white,),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),

                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          timeView(Icons.drive_eta, '24 Rides'),
                                                          timeView(Icons.route_rounded, '24 Rides'),
                                                          timeView(Icons.star, '4.5'),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                      ) :Card(
                                          child: Container(
                                            width: screenWidth * 0.85,
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
                                                              backgroundColor: primaryColor,
                                                              radius: 30,
                                                              child: Icon(Icons.account_circle,color:Colors.white,size: 60,),
                                                            ),
                                                            Positioned(bottom:0,right:0,child: Icon(Icons.verified_user_rounded,color: primaryLightColor,))
                                                          ],
                                                        ),
                                                        addHorizontalSpace(10),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Co-rider name',style: TextStyleUtils.primaryTextSemiBold.copyWith(color: primaryColor),),
                                                            Align(alignment:Alignment.topLeft,child: Text('Designation',style: TextStyleUtils.primaryTextRegular.copyWith(fontSize: 12),textAlign: TextAlign.start,)),
                                                          ],
                                                        )
                                                      ],

                                                    ),
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: primaryColor,
                                                      child: Icon(Icons.message,size: 20,color: Colors.white,),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                ),

                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      timeView(Icons.drive_eta, '24 Rides'),
                                                      timeView(Icons.route_rounded, '24 Rides'),
                                                      timeView(Icons.star, '4.5'),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                );
                              }),
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
    );
  }
  Widget outlineButtonView(String buttonName, VoidCallback onClick) =>
      OutlinedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              minimumSize: const Size(150, 40)),
          onPressed: () {
            onClick;
          },
          child: Text(
            buttonName,
            style: const TextStyle(color: Colors.blue),
          ));

  Widget elevatedButtonView(String buttonName,Color color, VoidCallback onClick) =>
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              minimumSize: const Size(150, 40)),
          onPressed:onClick,
          child: Text(
            buttonName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.2,
              fontFamily: 'PoppinsBold',
            ),
          ));

}
