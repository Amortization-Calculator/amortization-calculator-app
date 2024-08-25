import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/mortgage_service.dart';

class MortgageBasedSalaryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController salaryController = TextEditingController(text: '0');
  final TextEditingController interestRateController = TextEditingController(text: '0');
  final FocusNode salaryFocusNode = FocusNode();
  final FocusNode interestRateFocusNode = FocusNode();
  var sliderValue = 1.0.obs;
  var unitPrice = 0.0.obs;
  var downPayment = 0.0.obs;
  var amountFinance = 0.0.obs;
  var monthlyInstallment = 0.0.obs;
  var grossReceivable = 0.0.obs;

  final NumberFormat currencyFormatter = NumberFormat('#,##0', 'en_US');
  final MortgageService _mortgageService = MortgageService();

  @override
  void onInit() {
    salaryController.addListener(_updateValues);
    interestRateController.addListener(_updateValues);
    super.onInit();
  }

  @override
  void onClose() {
    salaryController.removeListener(_updateValues);
    interestRateController.removeListener(_updateValues);
    salaryController.dispose();
    interestRateController.dispose();
    super.onClose();
  }

  void _updateValues() {
    double salary = double.tryParse(salaryController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;
    amountFinance.value = _mortgageService.calculateAmountFinanceBySalary(sliderValue.value,salary);
    downPayment.value = _mortgageService.calculateDownPayment(amountFinance.value);
    unitPrice.value = _mortgageService.calculateUnitPrice(downPayment.value, amountFinance.value);
    monthlyInstallment.value = _mortgageService.calculateMonthlyInstallment(
        amountFinance.value,
        interestRate,
        sliderValue.value.round()
    );

  }

  void updateSliderValue(double value) {
    sliderValue.value = value;
    _updateValues();
  }
}
