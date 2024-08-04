import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_endpoints.dart';

class PdfService {
  final String getPdfUrl = '${ApiEndpoints.baseUrl}${ApiEndpoints.calculator.calc}pdf/';

  Future<File?> fetchPdf(String filename) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token not found');
      throw Exception('Token not found');
    }

    final url = Uri.parse('$getPdfUrl$filename');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Content-Type: ${response.headers['content-type']}');
      print('Response Content-Disposition: ${response.headers['content-disposition']}');

      if (response.statusCode == 200) {
        if (response.headers['content-type'] == 'application/pdf') {
          final contentDisposition = response.headers['content-disposition'];
          final pdfFilename = contentDisposition?.split('filename=').last ?? filename;

          final fileBytes = response.bodyBytes;
          final tempDir = Directory.systemTemp;
          final tempFilePath = '${tempDir.path}/${Uri.decodeComponent(pdfFilename)}';
          final tempFile = File(tempFilePath);

          // Save file
          await tempFile.writeAsBytes(fileBytes);
          print('File saved at: $tempFilePath');
          return tempFile;
        } else {
          print('The fetched file is not a PDF. Content-Type: ${response.headers['content-type']}');
          throw Exception('Fetched file is not a PDF');
        }
      } else {
        print('Failed to load PDF. Status code: ${response.statusCode}');
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error fetching PDF: $e');
      return null;
    }
  }
}
