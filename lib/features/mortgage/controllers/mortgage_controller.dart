import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/mortgage_service.dart';

class MortgageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController unitPriceController = TextEditingController(text: '0');
  final TextEditingController downPaymentForTheUnitController = TextEditingController(text: '0');
  final TextEditingController interestRateController = TextEditingController(text: '0');
  final FocusNode unitPriceFocusNode = FocusNode();
  final FocusNode interestRateFocusNode = FocusNode();
  final FocusNode downPaymentForTheUnitFocusNode = FocusNode();

  var sliderValue = 1.0.obs;
  var financeAmount = 0.0.obs;
  var monthlyInstallment = 0.0.obs;
  final NumberFormat currencyFormatter = NumberFormat('#,##0', 'en_US');

  final MortgageService _mortgageService = MortgageService();

  @override
  void onInit() {
    unitPriceController.addListener(_updateValues);
    downPaymentForTheUnitController.addListener(_updateValues);
    interestRateController.addListener(_updateValues);
    super.onInit();
  }

  @override
  void onClose() {
    unitPriceController.removeListener(_updateValues);
    downPaymentForTheUnitController.removeListener(_updateValues);
    interestRateController.removeListener(_updateValues);
    unitPriceController.dispose();
    downPaymentForTheUnitController.dispose();
    interestRateController.dispose();
    super.onClose();
  }

  void _updateValues() {
    double unitPrice = double.tryParse(unitPriceController.text) ?? 0;
    double downPayment = double.tryParse(downPaymentForTheUnitController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;

    financeAmount.value = _mortgageService.calculateFinanceAmount(unitPrice, downPayment);
    monthlyInstallment.value = _mortgageService.calculateMonthlyInstallment(
        financeAmount.value,
        interestRate,
        sliderValue.value.round()
    );
  }

  void updateSliderValue(double value) {
    sliderValue.value = value;
    monthlyInstallment.value = _mortgageService.calculateMonthlyInstallment(
        financeAmount.value,
        double.tryParse(interestRateController.text) ?? 0,
        sliderValue.value.round()
    );
  }
}
