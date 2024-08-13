import 'dart:io';

import 'package:get/get.dart';
import '../models/result_model.dart';

class ResultController extends GetxController {
  final ResultModel model = ResultModel();

  RxInt? rentalValue = 0.obs;
  RxString? originalAmountFinance = ''.obs;
  RxString? originalAssetCost = ''.obs;
  RxInt? originalRentalValue = 0.obs;

  Future<void> fetchAndOpenExcelFile(String filename) async {
    await model.fetchAndOpenExcelFile(filename);
  }
  Future<File?> fetchExcelFile(String filename) async {
   return await model.fetchExcelFile(filename);
  }

  Future<void> fetchAndOpenPdfFile(String filename) async {
    await model.fetchAndOpenPdfFile(filename);
  }

}
