import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/result_screen.dart';
import '../services/calc_service.dart';

class CalcController extends GetxController {
  var isLoading = false.obs;
  final CalcService calcService = CalcService();

  Future<void> calculate({
    required double assetCost,
    required double amountFinance,
    required double interestRate,
    required double effectiveRate,
    required int noOfRental,
    required int rentalInterval,
    required double residualValue,
    required double gracePeriod,
    required bool beginning,
    required bool startFromFirstMonth,
  }) async {
    isLoading(true);
    try {
      final result = await calcService.calculate(
        assetCost: assetCost,
        amountFinance: amountFinance,
        interestRate: interestRate,
        effectiveRate: effectiveRate,
        noOfRental: noOfRental,
        rentalInterval: rentalInterval,
        residualValue: residualValue,
        gracePeriod: gracePeriod,
        beginning: beginning,
        startFromFirstMonth: startFromFirstMonth,
      );

      if (result['success']) {
        print('Rental Value: ${result['rental']}');
        print('Excel File: ${result['excelFile']}');
        Get.to(
              () => const ResultScreen(),
          arguments: {
            'rentalValue': result['rental'],
            'excelFile': result['excelFile'],
          },
        );
      } else {
        print('Calculation failed: ${result['message']}');
        Get.defaultDialog(
          title: 'Error',
          middleText: result['message'],
          textConfirm: 'OK',
          onConfirm: () {
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
              Text(result['message']),
            ],
          ),
        );
      }
    } catch (error) {
      print('Calculation failed: $error');
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Calculation failed: $error',
        textConfirm: 'OK',
        onConfirm: () {
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
            Text('Calculation failed: $error'),
          ],
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
