import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:free_time_planner/features/free_time_planner/bottom_nav_view.dart';
import 'package:free_time_planner/features/recommendation_details/recommendation_details_view.dart';
import 'package:free_time_planner/onboarding/Intro_screen/intro_screen_view.dart';
import 'package:free_time_planner/onboarding/splash_screen/splash_screen_view.dart';
import 'package:free_time_planner/routes/exports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*if (!kIsWeb) {
    await Firebase.initializeApp();
  }*/

  runApp(
    //
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),

    //const MyApp(),
  );

  //
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //
      //useInheritedMediaQuery: true,
      //locale: DevicePreview.locale(context),
      //builder: DevicePreview.appBuilder,
      //
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF10225e, AppColors.primarySwatch),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreenView(),
      //getPages: RoutesClass.routes,
    );
  }
}
