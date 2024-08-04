import 'package:get/get.dart';

class HomeController extends GetxController {
  late final String name;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  void loadUserInfo() {
    final args = Get.arguments;
    final username = args['userName'] ?? 'User';
    final gender = args['gender'] ?? 'MALE';
    name = '${gender == 'MALE' ? 'Mr.' : 'Mrs.'} $username';
  }
}
