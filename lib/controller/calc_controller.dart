import 'package:get/get.dart';
import '../screens/result_screen.dart';
import '../services/calc_service.dart';

class CalcController {
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
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
