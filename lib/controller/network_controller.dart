import 'package:amortization_calculator_app/screens/no_internet_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// NetworkController.dart
class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatus.value = result;
    print(result);
    if (result == ConnectivityResult.none) {
      if (Get.currentRoute != '/noInternet') {
        Get.to(() => NoInternetScreen());
      }
    } else {
      if (Get.currentRoute == '/NoInternetScreen') {
        Get.back();
      }
    }
  }

  Future<ConnectivityResult> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }
  Future<void> retryConnection() async {

    ConnectivityResult result = await _connectivity.checkConnectivity();

    _updateConnectionStatus(result);
  }

}
