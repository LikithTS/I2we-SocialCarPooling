import 'package:common/utils/storageutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/font&margin/dimens.dart';
import 'package:socialcarpooling/font&margin/font_size.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/provider/driver_provider.dart';
import 'package:socialcarpooling/util/TextStylesUtil.dart';
import 'package:socialcarpooling/util/color.dart';
import 'package:socialcarpooling/utils/Localization.dart';
import 'package:socialcarpooling/view/splash/splash_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        return OverlaySupport(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en'),
            localizationsDelegates: const [DemoLocalizationsDelegate()],
            supportedLocales: const [Locale('en', '')],
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                          primary: buttonBgColor, onPrimary: Colors.white),
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
          ),
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
