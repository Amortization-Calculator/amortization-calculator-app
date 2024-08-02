import 'package:amortization_calculator_app/screens/auth/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amortization_calculator_app/screens/auth/login_screen.dart';
import 'package:amortization_calculator_app/screens/result_screen.dart';
import 'package:amortization_calculator_app/screens/home_screen.dart';
import 'package:amortization_calculator_app/screens/no_internet_screen.dart';

import 'controller/DependencyInjection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dependencyinjection.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Amortization Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white70,
          primary: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 1.0,
          maxScaleFactor: 1.3,
        );
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: scale,
          ),
          child: child!,
        );
      },
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        // Set initial route to SplashScreen
        GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
        GetPage(
            name: '/NoInternetScreen', page: () => const NoInternetScreen()),
        GetPage(name: '/ResultScreen', page: () => const ResultScreen()),
        GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
        // Ensure LoginScreen is accessible
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
