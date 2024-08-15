import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_endpoints.dart';

class DashboardService {
  final String _userUrl = ApiEndpoints.baseUrl + ApiEndpoints.dashboardEndpoints.allUsers;
  final String _deactivateUrl = ApiEndpoints.baseUrl + ApiEndpoints.dashboardEndpoints.allUsers;

  Future<String> _getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<int> fetchUserCount() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _getAuthToken()}',
    };

    try {
      final response = await http.get(
        Uri.parse(_userUrl),
        headers: headers,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['count'];
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> deactivateAllUsers() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _getAuthToken()}',
    };

    try {
      final response = await http.post(
        Uri.parse(_deactivateUrl),
        headers: headers,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        throw Exception('Failed to deactivate users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}
