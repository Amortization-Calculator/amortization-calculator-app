import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
class NetworkController  extends GetxController{
  final Connectivity _connectivity =Connectivity();
  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }
  void _updateConnectivityStatus(ConnectivityResult){
    if(ConnectivityResult.none){

    }

  }


}