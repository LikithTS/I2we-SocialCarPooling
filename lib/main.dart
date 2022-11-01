import 'package:common/utils/storageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/util/dimens.dart';
import 'package:socialcarpooling/util/font_size.dart';
import 'package:socialcarpooling/utils/Localization.dart';
import 'package:socialcarpooling/view/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    initConfiguration();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => DriverProvider()),
    ],
    child: ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates: const [DemoLocalizationsDelegate()],
          supportedLocales: const [Locale('en', '')],
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyleUtils.primaryTextBold.copyWith(color: toolbarTitleColor, fontSize: textsize22sp),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            )
          ),
          home: child,
        );
      },
      child: const SplashScreenPage(),
    ));
  }

  void initConfiguration() {
    PreferencesUtil.getInstance();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
  }
}
