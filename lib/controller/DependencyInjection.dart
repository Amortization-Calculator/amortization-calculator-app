import 'package:amortization_calculator_app/controller/network_controller.dart';
import 'package:get/get.dart';

class Dependencyinjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}