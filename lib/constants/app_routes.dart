import 'package:amortization_calculator_app/features/auth/screens/splash_screen.dart';
import 'package:amortization_calculator_app/features/mortgage/screens/mortgage_screen.dart';
import 'package:get/get.dart';
import 'package:amortization_calculator_app/features/home/screens/home_screen.dart';
import 'package:amortization_calculator_app/features/leasing/screens/result_screen.dart';
import 'package:amortization_calculator_app/features/leasing/screens/leasing_screen.dart';
import 'package:amortization_calculator_app/features/internet/screens/no_internet_screen.dart';
import 'package:amortization_calculator_app/features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/NoInternetScreen', page: () => const NoInternetScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
    GetPage(name: '/RegisterScreen', page: () => const RegisterScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/LeasingScreen', page: () => LeasingScreen()),
    GetPage(name: '/ResultScreen', page: () => const ResultScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/MortgageScreen', page: () => const MortgageScreen()),

  ];
}