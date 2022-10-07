import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/view/intro/intro_page.dart';
import 'package:socialcarpooling/view/questionarie/questionarie_view.dart';

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
                imageSlide("assets/images/intro_one.png"),
                SizedBox(height: 10.h,),
                headerText('Hi, Welcome'),
                SizedBox(height: 10.h,),
                smallText('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car')
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
                imageSlide("assets/images/intro_two.png"),
                SizedBox(height: 10.h,),
                headerText('Save Fuel'),
                SizedBox(height: 10.h,),
                smallText('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car')
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
                imageSlide("assets/images/intro_three.png"),
                SizedBox(height: 10.h,),
                headerText('Save Environment'),
                SizedBox(height: 10.h,),
                smallText('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car')
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
                imageSlide("assets/images/intro_four.png"),
                SizedBox(height: 10.h,),
                headerText('Make New Friends'),
                SizedBox(height: 10.h,),
                smallText('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car')
              ],
            )),
      ],
      onIntroCompleted: () {
        print("Into is Completed");
         Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child:QuestionariePage()));
      },
    );
  }

  Widget imageSlide(String url) => Image.asset(url,width: 300.w,height: 250.h,
      fit: BoxFit.cover);

  Widget smallText(String text) =>   Container(
      margin: EdgeInsets.only(left: 30,right:100),
      child: Align(
        alignment: Alignment.topLeft,
        child: Expanded(
          child: Text('A carpool is simple. It’s an arrangement between two or more people to make a regular journey in a single car',
            style: TextStyle(fontSize:14.sp,height:1.3,color: Colors.black,fontWeight:FontWeight.normal,decoration: TextDecoration.none,fontFamily: 'Poppins'),maxLines: 3,),
        ),
      )
  );
  Widget headerText(String title) =>  Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: TextStyle(fontSize:29.sp,decoration: TextDecoration.none,color: primaryColor,fontWeight: FontWeight.bold,fontFamily: 'Poppins')),
      )
  );

}
