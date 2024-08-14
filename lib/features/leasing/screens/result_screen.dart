import 'dart:io';
import 'package:amortization_calculator/widgets/custom_appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../controllers/result_controller.dart';
import '../../../widgets/build_rich_text_widget.dart';
import '../widgets/custom_circular_indicator.dart';
import '../widgets/custom_result_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResultController controller = Get.put(ResultController());
    final arguments = Get.arguments as Map<String, dynamic>?;

    controller.originalRentalValue.value = arguments?['rentalValue']?.round();
    controller.originalAmountFinance.value =
        arguments?['amountFinance']?.toString() ?? '1';
    controller.originalAssetCost.value =
        arguments?['assetCost']?.toString() ?? '0';

    final percentage = ((double.parse(controller.originalAmountFinance.value)) /
        double.parse(controller.originalAssetCost.value))
        .clamp(0.0, 1.0);
    final excelFile = arguments?['excelFile'] ?? '';
    final formattedRentalValue = NumberFormat('#,###')
        .format(controller.originalRentalValue.value);

    final Rx<File?> pdfFile = Rx<File?>(null);
    final Rx<File?> excelFileToShare = Rx<File?>(null);


    Future<void> fetchAndOpenPdfFile() async {
      pdfFile.value ??= await controller.fetchPdfFile(excelFile.replaceAll('.xlsx', '.pdf'));
      if (pdfFile.value != null) {
        await controller.openFile(pdfFile.value!);
      } else {
        Get.snackbar(
          'Error',
          'PDF file not found!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
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
            CustomCircularIndicator(
              percentage: percentage,
            ),
            const Spacer(),
            CustomResultButton(
              buttonText: 'Open Excel Sheet',
              imagePath: 'lib/assets/excel.png',
              buttonColor: Colors.white60,
              textColor: Colors.black,
              onPressed: () async {
                excelFileToShare.value ??= await controller.fetchExcelFile(excelFile);
                if (excelFileToShare.value != null) {
                  await controller.openFile(excelFileToShare.value!);
                } else {
                  Get.snackbar(
                    'Error',
                    'Excel file not found!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            CustomResultButton(
              buttonText: 'Open PDF File',
              imagePath: 'lib/assets/pdf.png',
              buttonColor: Colors.teal,
              onPressed: fetchAndOpenPdfFile,
            ),
            const SizedBox(height: 20),
            CustomResultButton(
              buttonText: 'Share',
              iconData: Icons.share,
              buttonColor: const Color(0xFFd32f2e),
              onPressed: () async {
                excelFileToShare.value ??= await controller.fetchExcelFile(excelFile);
                pdfFile.value ??= await controller.fetchPdfFile(excelFile);

                if (excelFileToShare.value != null && pdfFile.value != null) {
                  Share.shareXFiles(
                    [
                      XFile(excelFileToShare.value!.path),
                      XFile(pdfFile.value!.path),
                    ],
                    text: 'Here are the calculation files for your review.',
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Files not found!',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
