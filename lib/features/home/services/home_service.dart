import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService extends GetxController {
  RxString userName = 'User'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userName') ?? 'User';
    final gender = prefs.getString('gender') ?? 'Mr.';
    userName.value = '${gender == 'MALE' ? 'Mr.' : 'Mrs.'} $username';
  }
}
