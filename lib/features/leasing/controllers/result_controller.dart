import 'dart:io';
import 'package:get/get.dart';
import '../models/result_model.dart';

class ResultController extends GetxController {
  final ResultModel model = ResultModel();

  RxString originalAmountFinance = ''.obs;
  RxString originalAssetCost = ''.obs;
  RxInt originalRentalValue = 0.obs;

  Future<void> fetchAndOpenExcelFile(String filename) async {
    await model.fetchAndOpenExcelFile(filename);
  }

  Future<void> openFile(File file) async {
    await model.openFile(file);
  }

  Future<File?> fetchExcelFile(String filename) async {
    return await model.fetchExcelFile(filename);
  }

  Future<File?> fetchPdfFile(String filename) async {
    return await model.fetchPdfFile(filename);
  }

  Future<void> fetchAndOpenPdfFile(String filename) async {
    await model.fetchAndOpenPdfFile(filename);
  }
}
