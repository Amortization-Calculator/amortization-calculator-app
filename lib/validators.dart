import 'package:flutter/material.dart';

//                          leasing form validators
String? validateAssetCost(String? value, TextEditingController amountFinancedController) {
  if (value == null || value.isEmpty) {
    return null;
  }
  double? assetCost = double.tryParse(value);
  double? amountFinanced = double.tryParse(amountFinancedController.text);
  if (assetCost == null) {
    return 'Invalid Asset Cost';
  }
  if (amountFinanced != null && assetCost < amountFinanced) {
    return 'Asset Cost must be at least as Amount Financed';
  }
  if(amountFinanced != null&& (assetCost/amountFinanced)*100>90) {
    return 'Financing Ratio cno not be more than 90 %';
  }
  return null;
}

String? validateAmountFinanced(String? value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter Amount Financed';
  }
  return null;
}

String? validateNumberOfRentals(String? value) {
  if (value == null || value.isEmpty || int.tryParse(value) == null) {
    return 'Please enter Number Of Rentals';
  }
  return null;
}

String? validateInterestRate(String? value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter margin interest rate';
  }
  return null;
}

String? validateGracePeriod(String? value) {
  if (value == null || value.isEmpty || int.tryParse(value) == null) {
    return 'Please enter Grace Period';
  }
  return null;
}

String? validateResidualAmount(String? value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter Residual Amount';
  }
  return null;
}
//--------------------------------------------------------------