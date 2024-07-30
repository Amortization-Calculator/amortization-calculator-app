import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/api_endpoints.dart';

class RegisterService {
  final String _registerUrl = ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.register;

  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required String userType,
  }) async {
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'userType': userType,
    });

    try {
      final response = await http.post(Uri.parse(_registerUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Registration successful'}; // Registration successful
      } else {
        return {'success': false, 'message': json.decode(response.body)['message'] ?? 'Registration failed'}; // Registration failed with message
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()}; // Error occurred
    }
  }
}
