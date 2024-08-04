import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_endpoints.dart';

class CalcService {
  final String _calcUrl = ApiEndpoints.baseUrl + ApiEndpoints.calculator.calc;

  Future<String> _getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<Map<String, dynamic>> calculate({
    required double assetCost,
    required double amountFinance,
    required double interestRate,
    required double effectiveRate,
    required int noOfRental,
    required int rentalInterval,
    required double residualValue,
    required double gracePeriod,
    required bool beginning,
    required bool startFromFirstMonth,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _getAuthToken()}',
    };

    final body = json.encode({

        'AssetCost': assetCost,
        'AmountFinance': amountFinance,
        'intrestRate': interestRate,
        'EffectiveRate': effectiveRate,
        'NoOfRental': noOfRental,
        'RentalInterval': rentalInterval,
        'resedialValue': residualValue,
        'gressPriod': gracePeriod,
        'begining': beginning,
        'startFromFristMonth': startFromFirstMonth,

    });

    print("Request URL: $_calcUrl");
    print("Request Headers: $headers");
    print("Request Body: $body");

    try {
      final response = await http
          .post(
        Uri.parse(_calcUrl),
        headers: headers,
        body: body,
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': true,
          'rental': responseData['rental'],
          'excelFile': responseData['excelFile'],
        };
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Request failed with status: ${response.statusCode}'
        };
      }
    } catch (e) {
      print('Error during calculation: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
