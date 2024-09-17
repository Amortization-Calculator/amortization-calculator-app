import 'package:flutter/material.dart';

//--------------------------------------------------------------
//                          leasing form validators
//--------------------------------------------------------------

String? validateAssetCost(
    String? value, TextEditingController amountFinancedController) {
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
  if (amountFinanced != null && (amountFinanced / assetCost) * 100 > 90) {
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
    return 'Please enter Number Of Years';
  }
  return null;
}

String? validateInterestRate(String? value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter the interest rate';
  }
  if (double.tryParse(value)! > 100.0) {
    return 'interest rate can not be more than 100';
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
//                       register form validators
//--------------------------------------------------------------
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final regExp = RegExp(emailPattern);
  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  const phonePattern = r'^01[0125][0-9]{8}$';
  final regExp = RegExp(phonePattern);
  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.length < 8) {
    return 'The password must be at least 8 characters';
  }
  return null;
}

String? validateConfirmPassword(String? value, String? password) {
  if (value == null || value.length < 8) {
    return 'The password must be at least 8 characters';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

//--------------------------------------------------------------
//                          mortgage form validators
//--------------------------------------------------------------
String? unitPrice(String? value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter the unit Price';
  }
  if (value.toString().length >= 9) {
    return 'unitPrice must be less than 9 numbers';
  }
  return null;
}

String? downPaymentForTheUnit(String? value, TextEditingController unitPrice) {
  double? unitPriceValue = double.tryParse(unitPrice.text);

  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter the down Payment For The Unit';
  }
  if (unitPriceValue != null &&
      (double.tryParse(value)! / unitPriceValue) * 100 < 20) {
    return 'down Payment For The Unit must be at least 20%';
  }
  if (unitPriceValue != null && (double.tryParse(value)! > unitPriceValue)) {
    return 'Down Payment Can not be more than the Unit Price';
  }
  return null;
}

String? validateSalary(value) {
  if (value == null || value.isEmpty || double.tryParse(value) == null) {
    return 'Please enter a valid salary';
  }
  if (value.toString().length >= 9) {
    return 'salary must be less than 9 numbers';
  }
  return null;
}
