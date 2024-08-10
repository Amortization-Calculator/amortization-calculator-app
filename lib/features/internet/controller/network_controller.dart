import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../screens/no_internet_screen.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    tryConnect();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatus.value = result;

    if (result == ConnectivityResult.none) {
      if (Get.currentRoute != '/NoInternetScreen') {
        Get.offAll(() => const NoInternetScreen());
      }
    } else {
      if (Get.currentRoute == '/NoInternetScreen') {
        Get.back(); // Go back to the previous screen
      }
    }
  }

  Future<ConnectivityResult> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  Future<void> tryConnect() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }
}
