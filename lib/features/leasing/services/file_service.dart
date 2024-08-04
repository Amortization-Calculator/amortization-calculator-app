import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_endpoints.dart';

class FileService {
  final String getFileUrl = ApiEndpoints.baseUrl + ApiEndpoints.calculator.calc;

  Future<File?> fetchFile(String filename) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token not found');
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
        print('File fetched successfully');
        final fileBytes = response.bodyBytes;
        final tempDir = Directory.systemTemp;
        final tempFilePath = '${tempDir.path}/$filename';
        final tempFile = File(tempFilePath);

        // Ensure file does not already exist
        if (await tempFile.exists()) {
          print('File already exists: $tempFilePath');
        }

        // Save file
        await tempFile.writeAsBytes(fileBytes);
        print('File saved at: $tempFilePath');
        return tempFile;
      } else {
        print('Failed to load file. Status code: ${response.statusCode}');
        throw Exception('Failed to load file');
      }
    } catch (e) {
      print('Error fetching file: $e');
      return null;
    }
  }
}
