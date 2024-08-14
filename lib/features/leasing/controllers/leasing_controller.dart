import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/enums.dart';
import 'calc_controller.dart';

class LeasingController extends GetxController {
  final CalcController calcController = CalcController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool? checkBox = false;
  String? valueChoose = "4 - Quarterly";

  // Display strings and corresponding numeric values
  final Map<String, int> displayToValueMap = {
    "1 - Yearly": 1,
    "2 - Semi Annually": 2,
    "4 - Quarterly": 4,
    "12 - Monthly": 12,
  };

  final List<String> listItem = [
    "1 - Yearly",
    "2 - Semi Annually",
    "4 - Quarterly",
    "12 - Monthly"
  ];

  Rx<AdvanceArrearsEnum?> advanceArrearsEnum = AdvanceArrearsEnum.advance.obs;

  final TextEditingController marginInterestRateController = TextEditingController();
  final TextEditingController assetCostController = TextEditingController();
  final TextEditingController amountFinancedController = TextEditingController();
  final TextEditingController numberOfRentalsController = TextEditingController();
  final TextEditingController gracePeriodController = TextEditingController(text: '0');
  final TextEditingController residualAmountController = TextEditingController(text: '0');

  final FocusNode marginInterestRateFocusNode = FocusNode();
  final FocusNode assetCostFocusNode = FocusNode();
  final FocusNode amountFinancedFocusNode = FocusNode();
  final FocusNode numberOfRentalsFocusNode = FocusNode();
  final FocusNode gracePeriodFocusNode = FocusNode();
  final FocusNode residualAmountFocusNode = FocusNode();
  final FocusNode submitFocusNode = FocusNode();

  // Get numeric value based on the display string
  int get rentalIntervalValue => displayToValueMap[valueChoose!] ?? 1;

  Future<void> calculate() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;

      await calcController.calculate(
        amountFinance: double.parse(amountFinancedController.text),
        assetCost: double.parse(assetCostController.text),
        interestRate: double.parse(marginInterestRateController.text)/100,
        gracePeriod: double.parse(gracePeriodController.text),
        effectiveRate: double.parse(marginInterestRateController.text),
        noOfRental: int.parse(numberOfRentalsController.text)*12,
        rentalInterval: rentalIntervalValue, // Use the numeric value
        beginning: advanceArrearsEnum.value == AdvanceArrearsEnum.advance,
        residualValue: double.parse(residualAmountController.text),
        startFromFirstMonth: false,
      );

      isLoading.value = false;
    }
  }

  void onCalculateButtonPressed() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      await calculate();
      isLoading.value = false;
    }
  }
}
