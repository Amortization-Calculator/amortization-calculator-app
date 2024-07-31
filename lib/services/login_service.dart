import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_endpoints.dart';

class LoginService {
  final String _loginUrl = ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.login;

  Future<Map<String, dynamic>> loginUser({
    required String userName,
    required String password,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'userName': userName,
      'password': password,
    });

    try {
      final response = await http
          .post(
        Uri.parse(_loginUrl),
        headers: headers,
        body: body,
      )
          .timeout(
        const Duration(
          seconds: 10,
        ),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'userName': responseData['name'],
          'gender': responseData['userGender'],
          'token': responseData['acssesToken'],
          'expireDate': responseData['expierAt'],
        };
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
