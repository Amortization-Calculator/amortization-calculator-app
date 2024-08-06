
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getExpireDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('expireDate');
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('expireDate');
  }
}
