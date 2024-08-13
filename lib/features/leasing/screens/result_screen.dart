import 'dart:io';

import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../controllers/result_controller.dart';
import '../../../widgets/build_rich_text_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResultController controller = Get.put(ResultController());
    final arguments = Get.arguments as Map<String, dynamic>?;

    controller.originalRentalValue?.value = arguments?['rentalValue']?.round();
    controller.originalAmountFinance?.value =
        arguments?['amountFinance']?.toString() ?? '1';
    controller.originalAssetCost?.value =
        arguments?['assetCost']?.toString() ?? '0';

    final percentage = ((double.parse(controller.originalAmountFinance!.value)) /
        double.parse(controller.originalAssetCost!.value))
        .clamp(0.0, 1.0);
    final excelFile = arguments?['excelFile'] ?? '';
    final formattedRentalValue =
    NumberFormat('#,###').format(controller.originalRentalValue?.value ?? 0);

    File? fileToShare;

    return Scaffold(
      appBar: const CustomAppBar(),
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
            const CustomDividerWidget(),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
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
                          text: formattedRentalValue.toString(),
                          style: const TextStyle(
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
                onPressed: () async {
                  await controller.fetchAndOpenExcelFile(excelFile);
                },
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
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  await controller
                      .fetchAndOpenPdfFile(excelFile.replaceAll('.xlsx', '.pdf'));
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
                    'lib/assets/pdf.png',
                    height: 24.0,
                    width: 24.0,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Open PDF File      ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (fileToShare != null) {
                  Share.shareXFiles([XFile(fileToShare!.path)]);
                } else {
                  fileToShare = await controller.fetchExcelFile(excelFile);
                  if (fileToShare != null) {
                    Share.shareXFiles([XFile(fileToShare!.path)]);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd32f2e),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
