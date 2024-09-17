import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/mortgage_service.dart';

class MortgageBasedSalaryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController salaryController =
      TextEditingController(text: '0');
  final TextEditingController interestRateController =
      TextEditingController(text: '0');
  final FocusNode salaryFocusNode = FocusNode();
  final FocusNode interestRateFocusNode = FocusNode();
  var sliderValue = 1.0.obs;
  var unitPrice = 0.0.obs;
  var downPayment = 0.0.obs;
  var amountFinance = 0.0.obs;
  var monthlyInstallment = 0.0.obs;
  var grossReceivable = 0.0.obs;
  var isValid = false.obs;

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

  void _checkValidity() {
    final salaryValid = double.tryParse(salaryController.text) != null&&salaryController.text.length<9;
    final interestRateValid =
        double.tryParse(interestRateController.text) != null &&
            double.tryParse(interestRateController.text)! <= 100.0;

    isValid.value = salaryValid && interestRateValid;
  }

  void _updateValues() {
    _checkValidity();
    double salary = double.tryParse(salaryController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;
    monthlyInstallment.value =
        _mortgageService.calculateMonthlyInstallmentSalaryBased(salary: salary);
    amountFinance.value = _mortgageService
        .calculateAmountFinanceBySalary(
          years: sliderValue.value,
          salary: salary,
          rate: interestRate,
          monthlyInstallment: monthlyInstallment.value,
        )
        .toDouble();

    downPayment.value = _mortgageService.calculateDownPayment(
      amountFinance: amountFinance.value,
    );
    unitPrice.value = _mortgageService.calculateUnitPrice(
      amountFinance: amountFinance.value,
      downPayment: downPayment.value,
    );
    grossReceivable.value = _mortgageService.grossReceivable(
      monthlyInstallment: monthlyInstallment.value,
      duration: sliderValue.value,
    );
  }

  void updateSliderValue(double value) {
    sliderValue.value = value;
    _updateValues();
  }
}
