import 'package:flutter/material.dart';
import '../../../constants/enums.dart';
import 'calc_controller.dart';

class LeasingScreenController {
  final CalcController calcController = CalcController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool? checkBox = false;
  String? valueChoose = "4";
  final List<String> listItem = ["1", "2", "4", "12"];
  AdvanceArrearsEnum? advanceArrearsEnum = AdvanceArrearsEnum.advance;

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


  Future<void> calculate() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;

      await calcController.calculate(
        amountFinance: double.parse(amountFinancedController.text),
        assetCost: double.parse(assetCostController.text),
        interestRate: double.parse(marginInterestRateController.text),
        gracePeriod: double.parse(gracePeriodController.text),
        effectiveRate: double.parse(marginInterestRateController.text),
        noOfRental: int.parse(numberOfRentalsController.text),
        rentalInterval: int.parse(valueChoose!),
        beginning: (advanceArrearsEnum == AdvanceArrearsEnum.advance) ? true : false,
        residualValue: double.parse(residualAmountController.text),
        startFromFirstMonth:false,
      );

      isLoading = false;
    }
  }
}
