import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/utils/Localization.dart';
import 'package:socialcarpooling/view/home/home_cards/add_car_home_view.dart';
import 'package:socialcarpooling/view/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates: const [DemoLocalizationsDelegate()],
          supportedLocales: const [Locale('en','')],
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
          home: child,
        );
      },
      child: SplashScreenPage(),
    );
  }
}
