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

  double calculateUnitPrice(
      {required double downPayment, required double amountFinance}) {
    return downPayment + amountFinance;
  }

  num calculateAmountFinanceBySalary({
    required double years,
    required double salary,
    required double rate,
    required double monthlyInstallment,
  }) {
    double numberOfPayments = years * 12;
    double monthlyRate = rate / 12 / 100;

    num result = finance.pv(
      rate: monthlyRate,
      nper: numberOfPayments,
      pmt: -monthlyInstallment,
      fv: 0,
      end: false,
    );

    return result;
  }

  double calculateDownPayment({required double amountFinance}) {
    return (amountFinance * 10.0 / 8.0) - amountFinance;
  }

  double grossReceivable(
      {required double duration, required double monthlyInstallment}) {
    return monthlyInstallment * (duration * 12);
  }

  double calculateMonthlyInstallment(
      {required double financeAmount,
      required double interestRate,
      required int years}) {
    double monthlyRate = interestRate / 12 / 100;
    int numberOfPayments = years * 12;

    num result = finance.pmt(
        rate: monthlyRate,
        nper: numberOfPayments,
        pv: -financeAmount,
        end: false);
    return max(0.0, result.toDouble());
  }

  double calculateMonthlyInstallmentSalaryBased({required double salary}) {
    return salary / 2;
  }
}
