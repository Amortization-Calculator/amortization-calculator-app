import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../services/mortgage_service.dart';

class MortgageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController unitPriceController =
      TextEditingController(text: '0');
  final TextEditingController downPaymentForTheUnitController =
      TextEditingController(text: '0');
  final TextEditingController interestRateController =
      TextEditingController(text: '0');
  final TextEditingController grossReceivableController =
      TextEditingController(text: '0');

  final FocusNode unitPriceFocusNode = FocusNode();
  final FocusNode interestRateFocusNode = FocusNode();
  final FocusNode downPaymentForTheUnitFocusNode = FocusNode();
  final FocusNode grossReceivableFocusNode = FocusNode();

  var sliderValue = 1.0.obs;
  var financeAmount = 0.0.obs;
  var monthlyInstallment = 0.0.obs;
  var grossReceivable = 0.0.obs;
  RxBool isValid= false.obs;
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
  void _checkValidity() {
    final unitValid = double.tryParse(unitPriceController.text) != null&&unitPriceController.text.length<9;
    final interestRateValid =
        double.tryParse(interestRateController.text) != null &&
            double.tryParse(interestRateController.text)! <= 100.0;

    isValid.value = unitValid && interestRateValid;
  }
  void _updateValues() {
    _checkValidity();
    double unitPrice = double.tryParse(unitPriceController.text)?? 0 ;
    double downPayment = double.tryParse(downPaymentForTheUnitController.text)?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;
    financeAmount.value = _mortgageService.calculateAmountFinanceByUnit(unitPrice, downPayment);
    monthlyInstallment.value = _mortgageService.calculateMonthlyInstallment(
      financeAmount: financeAmount.value,
      interestRate: interestRate,
      years: sliderValue.value.round(),
    );

    grossReceivable.value = _mortgageService.grossReceivable(
      duration: sliderValue.value,
      monthlyInstallment: monthlyInstallment.value,
    );
  }

  void updateSliderValue(double value) {
    sliderValue.value = value;
    _updateValues();
  }
}
