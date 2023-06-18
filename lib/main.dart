import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:common/utils/storageutil.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:socialcarpooling/util/Localization.dart';
import 'package:socialcarpooling/view/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _authStatus = 'Unknown';
  @override
  void initState() {
    super.initState();

    // It is safer to call native code using addPostFrameCallback after the widget has been fully built and initialized.
    // Directly calling native code from initState may result in errors due to the widget tree not being fully built at that point.
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => initPlugin());

  }

  @override
  Widget build(BuildContext context) {
    initConfiguration();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: primaryColor
          //color set to purple or set your own color
        )
    );
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
                          backgroundColor: primaryColor, foregroundColor: Colors.white),
                    ),
                    backgroundColor: Colors.white,
                    scaffoldBackgroundColor: Colors.white,
                    useMaterial3: true,
                    primaryColor: primaryColor,
                    appBarTheme: AppBarTheme(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: primaryColor,
                          // Status bar brightness (optional)
                          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                          statusBarBrightness: Brightness.light,
                      ),
                      color: primaryColor,
                      titleTextStyle: TextStyleUtils.primaryTextBold.copyWith(
                          color: toolbarTitleColor, fontSize: textsize22sp),
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.black),
                    )),
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
        const SystemUiOverlayStyle(statusBarColor: primaryColor));

  }

  Future<void> initPlugin() async {
    final TrackingStatus status =
    await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
                'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
                'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
}
