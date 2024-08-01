import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

// Print all the data for debugging purposes
      print('Asset Cost: $assetCost');
      print('Amount Finance: $amountFinance');
      print('Interest Rate: $interestRate');
      print('Effective Rate: $effectiveRate');
      print('Number of Rentals: $noOfRental');
      print('Rental Interval: $rentalInterval');
      print('Residual Value: $residualValue');
      print('Grace Period: $gracePeriod');
      print('Beginning: $beginning');
      print('Start From First Month: $startFromFirstMonth');

      // Check and log the result
      print('Calculation Result: $result');

      if (result['success']) {
        final rentalValue = result['rental'] ?? 'Unknown';
        final excelFile = result['excelFile'] ?? '';

        print('Rental Value: $rentalValue');
        print('Excel File: $excelFile');

        Get.to(
              () => ResultScreen(),
          arguments: {
            'rentalValue': rentalValue,
            'excelFile': excelFile,
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
