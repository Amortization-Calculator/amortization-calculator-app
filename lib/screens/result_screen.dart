import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/logout_service.dart';
import '../widgets/build_rich_text_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var _openResult = 'Unknown';
  File? _fileToShare;

  Future<void> openFile() async {
    if (_fileToShare != null) {
      // If the file is already created, try opening it
      final result = await OpenFile.open(_fileToShare!.path);
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });

      if (result.type == ResultType.noAppToOpen) {
        _showNoAppDialog();
      }
      return;
    }

    try {
      final ByteData data = await rootBundle.load('lib/assets/test.xlsx');
      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/test.xlsx');
      await tempFile.writeAsBytes(data.buffer.asUint8List());
      _fileToShare = tempFile;
      final result = await OpenFile.open(_fileToShare!.path);
      setState(() {
        _openResult = "type=${result.type}  message=${result.message}";
      });

      if (result.type == ResultType.noAppToOpen) {
        _showNoAppDialog();
      }
    } catch (e) {
      setState(() {
        _openResult = "Error: $e";
      });
    }
  }


  void _showNoAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Application Found"),
          content: Text(
              "No application is available to open this file. Please download an app that can open Excel files."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(right: 16.0), // Add padding here
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.black), // Logout icon
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
            SizedBox(height: 10.0), // Adjust this value to move the section up
            RichTextWidget(
              firstText: 'Calculation ',
              secondFontSize: 20,
              firstFontSize: 20,
              secondText: "Result",
            ),
            Divider(
              height: 20,
              thickness: 2,
              indent: 150,
              endIndent: 150,
              color: Color(0xFF94364a),
            ),

            SizedBox(height: 30.0), // Adjust this value to move the section up
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
                  SizedBox(height: 16.0),
                  Text(
                    'Rental Value Per Month',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '2000 EGP',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: openFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white60,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                minimumSize: Size(double.infinity, 50.0),
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
                  SizedBox(width: 10.0),
                  Text(
                    'Open Excel Sheet',
                    style: TextStyle(
                      // backgroundColor: Colors.black,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final ByteData data =
                await rootBundle.load('lib/assets/test.xlsx');
                final Directory tempDir = await getTemporaryDirectory();
                final File tempFile = File('${tempDir.path}/test.xlsx');
                await tempFile.writeAsBytes(data.buffer.asUint8List());
                _fileToShare = tempFile;
                Share.shareXFiles([XFile(_fileToShare!.path)]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                minimumSize: Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, size: 24.0, color: Colors.white),
                  SizedBox(width: 10.0),
                  Text(
                    'Share it',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
