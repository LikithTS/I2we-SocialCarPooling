import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:  ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
        ),),
          home: child,
        );
      },
      child:SplashScreenPage(),);
  }
}


