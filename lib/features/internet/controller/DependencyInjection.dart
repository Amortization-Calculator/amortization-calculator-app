import 'package:amortization_calculator_app/features/internet/controller/network_controller.dart';
import 'package:get/get.dart';

class Dependencyinjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}