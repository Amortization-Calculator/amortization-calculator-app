import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:get/get.dart';
import '../services/excel_service.dart';
import '../services/pdf_service.dart';

class ResultModel {
  File? fileToShare;
  int? rentalValue;
  int? originalRentalValue;
  String? originalAmountFinance;
  String? originalAssetCost;

  final ExcelService excelService = ExcelService();
  final PdfService pdfService = PdfService();

  Future<File?> fetchExcelFile(String filename) async {
    return await excelService.fetchFile(filename);
  }

  Future<void> openExcelFile(File file) async {
    try {
      final result = await OpenFile.open(file.path);
      if (result.type == ResultType.noAppToOpen) {
        _showNoAppDialog();
      }
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  Future<void> fetchAndOpenExcelFile(String filename) async {
    final file = await fetchExcelFile(filename);
    if (file != null) {
      fileToShare = file;
      await openExcelFile(file);
    }
  }

  Future<void> fetchAndOpenPdfFile(String filename) async {
    try {
      final file = await pdfService.fetchPdf(filename);
      if (file != null) {
        final result = await OpenFile.open(file.path);
        if (result.type == ResultType.noAppToOpen) {
          _showNoAppDialog();
        }
      }
    } catch (e) {
      print('Error fetching or opening PDF file: $e');
    }
  }

  void _showNoAppDialog() {
    Get.defaultDialog(
      title: "No Application Found",
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
            "No application is available to open this file.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
