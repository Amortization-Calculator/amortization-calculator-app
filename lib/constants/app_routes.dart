
import 'package:get/get.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/internet/screens/no_internet_screen.dart';
import '../features/leasing/screens/leasing_screen.dart';
import '../features/leasing/screens/result_screen.dart';
import '../features/mortgage/screens/mortgage_screen.dart';
import '../features/team/screens/team_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/NoInternetScreen', page: () => const NoInternetScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/LoginScreen', page: () => LoginScreen()),
    GetPage(name: '/RegisterScreen', page: () =>  RegisterScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/LeasingScreen', page: () => LeasingScreen()),
    GetPage(name: '/ResultScreen', page: () => const ResultScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/MortgageScreen', page: () => const MortgageScreen()),
    //----------------------------------------------------------------------
    GetPage(name: '/TeamScreen', page: () => const TeamScreen()),

  ];
}