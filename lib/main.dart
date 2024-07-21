import 'package:amortization_calculator_app/controller/DependencyInjection.dart';
import 'package:amortization_calculator_app/screens/auth/login_screen.dart';
import 'package:amortization_calculator_app/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/no_internet_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dependencyinjection.init();
  runApp(const MyApp());
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
        // Retrieve the MediaQueryData from the current context.
        final mediaQueryData = MediaQuery.of(context);

        // Calculate the scaled text factor using the clamp function to ensure it stays within a specified range.
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 1.0, // Minimum scale factor allowed.
          maxScaleFactor: 1.3, // Maximum scale factor allowed.
        );

        // Create a new MediaQueryData with the updated text scaling factor.
        // This will override the existing text scaling factor in the MediaQuery.
        // This ensures that text within this subtree is scaled according to the calculated scale factor.
        return MediaQuery(
          // Copy the original MediaQueryData and replace the textScaler with the calculated scale.
          data: mediaQueryData.copyWith(
            textScaler: scale,
          ),
          // Pass the original child widget to maintain the widget hierarchy.
          child: child!,
        );
      },
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page:()=> const LoginScreen()),
        GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
        GetPage(name: '/NoInternetScreen', page: () => const NoInternetScreen()),
        GetPage(name: '/ResultScreen', page: () => const ResultScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}