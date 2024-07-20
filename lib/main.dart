import 'package:flutter/material.dart';
import 'package:amortization_calculator_app/screens/home_screen.dart';

void main() {
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
    return MaterialApp(
      title: 'amortization_calculator_app',
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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
