import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_endpoints.dart';

class ExcelService {
  final String getFileUrl = ApiEndpoints.baseUrl + ApiEndpoints.calculator.calc;

  Future<File?> fetchFile(String filename) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('$getFileUrl$filename');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final fileBytes = response.bodyBytes;
        final tempDir = Directory.systemTemp;
        final tempFilePath = '${tempDir.path}/$filename';
        final tempFile = File(tempFilePath);

        // Save file
        await tempFile.writeAsBytes(fileBytes);
        return tempFile;
      } else {
        throw Exception('Failed to load file');
      }
    } catch (e) {
      print('Error fetching file: $e');
      return null;
    }
  }
}
