import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:get/get.dart';
import '../../auth/services/logout_service.dart';
import '../services/file_service.dart';
import '../../../widgets/build_rich_text_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  File? _fileToShare;
  int? _rentalValue;
  int? _originalRentalValue; // To store the original rental value
  String? _originalAmountFinance;

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
        print(
            'OpenFile result: type=${result.type}, message=${result.message}');

        if (result.type == ResultType.noAppToOpen) {
          _showNoAppDialog();
        }
      }
    } catch (e) {
      print('Error fetching or opening file: $e');
    }
  }

  void _showNoAppDialog() {
    
    Get.defaultDialog(
      title: "No Application Found",
      middleText:
          "No application is available to open this file. Please download an app that can open Excel files.",
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      },
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      barrierDismissible: false,
      radius: 10.0,
      content: const Column(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
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
    _originalRentalValue ??= arguments?['rentalValue']?.round();
    _originalAmountFinance ??= arguments?['amountFinance']?.toString() ?? '1';
    _rentalValue = _rentalValue ??
        _originalRentalValue;

    final amountFinance = arguments?['amountFinance']?.toString() ?? '1';

    final assetCost = arguments?['assetCost']?.toString() ?? '0';

    final percentage =
        (double.parse(amountFinance) / double.parse(assetCost)).clamp(0.0, 1.0);

    final excelFile = arguments?['excelFile'] ?? '';

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
            const SizedBox(height: 10.0),
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
              constraints: const BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _rentalValue?.toString() ?? 'N/A',
                          style:const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: ' EGP',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 15.0,
              animation: true,
              percent: percentage,
              center: Text(
                "${(percentage * 100).toStringAsFixed(1)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              footer: const Text(
                "Financing Ratio",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: const Color(0xFF94364a),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => {fetchAndOpenFile(excelFile),print('a')},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white60,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
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
                backgroundColor: const Color(0xFF148C79),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                minimumSize: const Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
