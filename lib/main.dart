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
          primary: Color(0xFF94364a),
          seedColor: Color(0xFF94364a),
          secondary: Colors.white,
        ),



        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
