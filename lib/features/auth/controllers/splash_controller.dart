import 'package:amortization_calculator/features/dashboard/screens/dashboard_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../../home/screens/home_screen.dart';
import '../../internet/controllers/network_controller.dart';
import '../../internet/screens/no_internet_screen.dart';
import '../screens/login_screen.dart';
import '../services/splash_service.dart';

class SplashController extends GetxController {
  final SplashService splashService = SplashService();
  final NetworkController networkController = Get.put(NetworkController());

  Future<void> checkLoginStatus() async {
    ConnectivityResult connectivityResult = await networkController.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoInternetScreen());
      return;
    }

    String? token = await splashService.getToken();
    String? expireDateStr = await splashService.getExpireDate();
    String? name = await splashService.getUserName();
    print('name');
    print(name);

    if (token != null && expireDateStr != null) {
      DateTime expireDate = DateTime.parse(expireDateStr);

      if (DateTime.now().isAfter(expireDate)) {
        await splashService.removeToken();
        Get.offAll(() => LoginScreen());
      } else {
        if(name=='admin'){
          Get.offAll(() =>  DashboardScreen());
        }else {
          Get.offAll(() => const HomeScreen());
        }
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
