import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_endpoints.dart';

class RegisterService {
  final String _registerUrl = ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.register;

  Future<Map<String, dynamic>> registerUser({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required String userType,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'userType': userType,
    });

    try {
      final response = await http
          .post(
        Uri.parse(_registerUrl),
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
          'message': responseData['message'],
          'isAuthSuccessful': responseData['isAuthSuccessful'],
          'email': responseData['email'],
          'userName': responseData['userName'],
          'gender': responseData['gender'],
          'userType': responseData['userType'],
          'token': responseData['token'],
          'expireDate': responseData['expireDate'],
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
