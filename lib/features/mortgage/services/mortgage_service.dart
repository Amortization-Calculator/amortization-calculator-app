import 'dart:math';
import 'package:finance_updated/finance_updated.dart';

class MortgageService {
  final Finance finance = Finance();

  double calculateFinanceAmount(double unitPrice, double downPayment) {
    if (unitPrice > 0 && downPayment >= 0 && downPayment >= 0.2 * unitPrice) {
      return (unitPrice - downPayment).roundToDouble();
    }
    return 0.0;
  }

  double calculateMonthlyInstallment(double financeAmount, double interestRate, int years) {
    double monthlyRate = interestRate / 100 / 12;
    int numberOfPayments = years * 12;

    num result = finance.pmt(
        rate: monthlyRate,
        nper: numberOfPayments,
        pv: -financeAmount
    );

    return max(0.0, result.toDouble());
  }
}
