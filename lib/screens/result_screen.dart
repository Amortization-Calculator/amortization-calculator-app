import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
        title: Image.asset(
          'lib/assets/logo-transparent-png.png',
          height: 60.0,
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '2000 EGP',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF94364a),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: openFile,
                icon: Image.asset(
                  'lib/assets/excel.png',
                  height: 24.0,
                  width: 24.0,
                ),
                label: Text('Open Excel Sheet'),
              ),
              SizedBox(width: 20.0),
              ElevatedButton.icon(
                /* try {
      getFile();
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
                * */
                onPressed: () async {
                  final ByteData data = await rootBundle.load('lib/assets/test.xlsx');
                  final Directory tempDir = await getTemporaryDirectory();
                  final File tempFile = File('${tempDir.path}/test.xlsx');
                  await tempFile.writeAsBytes(data.buffer.asUint8List());
                  _fileToShare = tempFile;
                  Share.shareXFiles([XFile(_fileToShare!.path)]);
                },
                icon: Icon(Icons.share),
                label: Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
