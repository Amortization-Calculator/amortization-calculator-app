import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import '../services/logout_service.dart';
import '../services/file_service.dart';
import '../widgets/build_rich_text_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var _openResult = 'Unknown';
  File? _fileToShare;

  Future<void> fetchAndOpenFile(String filename) async {
    print('Fetching file: $filename');
    final fileService = FileService();
    try {
      final file = await fileService.fetchFile(filename);
      if (file != null) {
        print('File found: ${file.path}');
        setState(() {
          _fileToShare = file;
        });

        final result = await OpenFile.open(file.path);
        print('OpenFile result: type=${result.type}, message=${result.message}');

        if (result.type == ResultType.noAppToOpen) {
          _showNoAppDialog();
        }

        setState(() {
          _openResult = "type=${result.type}  message=${result.message}";
        });
      } else {
        setState(() {
          _openResult = "Error: Failed to fetch the file";
        });
      }
    } catch (e) {
      print('Error fetching or opening file: $e');
      setState(() {
        _openResult = "Error: ${e.toString()}";
      });
    }
  }


  void _showNoAppDialog() {
    print('Showing no app dialog');
    Get.defaultDialog(
      title: "No Application Found",
      middleText: "No application is available to open this file. Please download an app that can open Excel files.",
      textConfirm: "OK",
      onConfirm: () {
        print('Dialog confirmed');
        Get.back();
      },
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      barrierDismissible: false,
      radius: 10.0,
      content: Column(
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(height: 10),
          const Text(
            "No application is available to open this file. Please download an app that can open Excel files.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    // final rentalValueStr = arguments?['rentalValue'] ?? '0.0';
    final rentalValue = arguments?['rentalValue'].round();

    final excelFile = arguments?['excelFile'] ?? '';

    // print("rentalValue: $Int.parse(rentalValue)");
    print("excelFile: $excelFile");

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Image.asset(
          'lib/assets/logo-transparent-png.png',
          height: 60.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () async {
                LogoutService logoutService = LogoutService();
                await logoutService.logout();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            const RichTextWidget(
              firstText: 'Calculation ',
              secondFontSize: 20,
              firstFontSize: 20,
              secondText: "Result",
            ),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 150,
              endIndent: 150,
              color: Color(0xFF94364a),
            ),
            const SizedBox(height: 30.0),
            Container(
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Rental Value Per Month',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '$rentalValue EGP',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => fetchAndOpenFile(excelFile),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white60,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                minimumSize: const Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/excel.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Open Excel Sheet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_fileToShare != null) {
                  Share.shareXFiles([XFile(_fileToShare!.path)]);
                } else {
                  await fetchAndOpenFile(excelFile);
                  if (_fileToShare != null) {
                    Share.shareXFiles([XFile(_fileToShare!.path)]);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                minimumSize: const Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.share, size: 24.0, color: Colors.white),
                  SizedBox(width: 10.0),
                  Text(
                    'Share it',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
