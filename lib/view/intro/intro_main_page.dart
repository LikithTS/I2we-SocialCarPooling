import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/view/home/home_page.dart';
import 'package:socialcarpooling/view/intro/intro_page.dart';
import 'package:socialcarpooling/widgets/text_widgets.dart';

class IntoMainPage extends StatelessWidget {
  const IntoMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroPage(
      pages: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 110),
            width: 390.w,height: 390.h,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/intro_one.png",
                     fit: BoxFit.cover),
               SizedBox(height: 10.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Hi, Welcome',
                          style: TextStyle(fontSize:29.sp,color: primaryColor,fontFamily: 'assets/fonts/poppins_bold.ttf')),
                    )
                ),
                SizedBox(height: 10.h,),
                Container(
                  margin: EdgeInsets.only(left: 30,right: 100),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Expanded(
                        child: Text('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car',
                          style: TextStyle(fontSize:14.sp,height:1.3,color: Colors.black,fontWeight:FontWeight.normal,fontFamily: 'assets/fonts/poppins_regular.ttf'),maxLines: 3,),
                      ),
                    )
                )
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: 110),
            width: 390.w,height: 390.h,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/intro_two.png",
                    fit: BoxFit.cover),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Hi, Welcome',
                          style: TextStyle(fontSize:29.sp,color: primaryColor,fontFamily: 'assets/fonts/poppins_bold.ttf')),
                    )
                ),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.only(left: 30,right: 100),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Expanded(
                        child: Text('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car',
                          style: TextStyle(fontSize:14.sp,height:1.3,color: Colors.black,fontWeight:FontWeight.normal,fontFamily: 'assets/fonts/poppins_regular.ttf'),maxLines: 3,),
                      ),
                    )
                )
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: 110),
            width: 390.w,height: 390.h,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/intro_three.png",
                    fit: BoxFit.cover),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Hi, Welcome',
                          style: TextStyle(fontSize:29.sp,color: primaryColor,fontFamily: 'assets/fonts/poppins_bold.ttf')),
                    )
                ),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.only(left: 30,right: 100),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Expanded(
                        child: Text('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car',
                          style: TextStyle(fontSize:14.sp,height:1.3,color: Colors.black,fontWeight:FontWeight.normal,fontFamily: 'assets/fonts/poppins_regular.ttf'),maxLines: 3,),
                      ),
                    )
                )
              ],
            )),
        Container(
            margin: EdgeInsets.only(top: 110),
            width: 390.w,height: 390.h,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/intro_four.png",width: 300,height: 250,
                    fit: BoxFit.cover),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Make New Friends',
                          style: TextStyle(fontSize:29.sp,color: primaryColor,fontFamily: 'assets/fonts/poppins_bold.ttf')),
                    )
                ),
                SizedBox(height: 10.h,),
                Container(
                    margin: EdgeInsets.only(left: 30,right:100),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Expanded(
                        child: Text('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car',
                          style: TextStyle(fontSize:14.sp,height:1.3,color: Colors.black,fontWeight:FontWeight.normal,fontFamily: 'assets/fonts/poppins_regular.ttf'),maxLines: 3,),
                      ),
                    )
                )
              ],
            )),
      ],
      onIntroCompleted: () {
        print("Into is Completed");
         Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child:HomePage()));
      },
    );
  }
}
