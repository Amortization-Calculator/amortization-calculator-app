import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  Future<String> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userName') ?? 'User';
    final gender = prefs.getString('gender') ?? 'Mr.';
    var name = '${gender == 'MALE' ? 'Mr.' : 'Mrs.'} $username';

    return name; // Return the constructed name
  }
}