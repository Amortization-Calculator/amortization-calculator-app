import 'dart:math';
import 'package:finance_updated/finance_updated.dart';

class MortgageService {
  final Finance finance = Finance();

  double calculateAmountFinanceByUnit(double unitPrice, double downPayment) {
    if (unitPrice > 0 && downPayment >= 0 && downPayment >= 0.2 * unitPrice) {
      return (unitPrice - downPayment).roundToDouble();
    }
    return 0.0;
  }

  double calculateUnitPrice(double downPayment, double amountFinance) {
    return downPayment + amountFinance;
  }

  double calculateAmountFinanceBySalary(double years, double salary) {
    return salary / 2 * years * 12;
  }

  double calculateDownPayment(double amountFinance) {
    return (amountFinance * 10.0 / 8.0) - amountFinance;
  }
  double grossReceivable(double duration,double monthlyInstallment){
    return monthlyInstallment*duration*12 ;
  }

  double calculateMonthlyInstallment(
      double financeAmount, double interestRate, int years) {
    double monthlyRate = interestRate / 100 / 12;
    int numberOfPayments = years * 12;

    num result = finance.pmt(
        rate: monthlyRate, nper: numberOfPayments, pv: -financeAmount);

    return max(0.0, result.toDouble());
  }
}
