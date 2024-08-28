import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class MortgageByUnitPricePdfService {
  final double unitPrice;
  final double downPayment;
  final double duration;
  final double amountFinance;
  final double monthlyInstallment;
  final double grossReceivable;
  final double salary;
  final String interestRate;

  MortgageByUnitPricePdfService( {
    required this.duration,
    required this.unitPrice,
    required this.downPayment,
    required this.amountFinance,
    required this.monthlyInstallment,
    required this.grossReceivable,
    required this.salary,
    required this.interestRate,
  });

  Future<void> generateAndSharePdf() async {
    final pdf = pw.Document();
    final imageProvider = await _loadImage();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Image(imageProvider, width: 100, height: 50),
                pw.SizedBox(width: 20),
                pw.Text(
                  'Mortgage Calculator by Unit Price',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Center(
              child: pw.Text(
                'Input Values',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
              children: [
                pw.TableRow(
                  children: [
                    _buildTableCell('Unit Price', bold: true),
                    _buildTableCell('${_formatNumber((unitPrice ))} EGP'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Down Payment For Unit Price', bold: true),
                    _buildTableCell('${_formatNumber(downPayment)} EGP'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Interest Rate', bold: true),
                    _buildTableCell('$interestRate %'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Duration', bold: true),
                    _buildTableCell('${duration.round()} Year'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Center(
              child: pw.Text(
                'Results',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(width: 1, color: PdfColors.grey),
              children: [
                pw.TableRow(
                  children: [
                    _buildTableCell('Amount Finance', bold: true),
                    _buildTableCell('${_formatNumber(amountFinance)} EGP'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Monthly Installment', bold: true),
                    _buildTableCell('${_formatNumber(monthlyInstallment)} EGP'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Expected Salary', bold: true),
                    _buildTableCell('${_formatNumber(salary)} EGP'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    _buildTableCell('Gross Receivable', bold: true),
                    _buildTableCell('${_formatNumber(grossReceivable)} EGP'),
                  ],
                ),
              ],
            ),
            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.bottomCenter,
              child: pw.Text(
                '© 2024 Amortization calculator. All rights reserved.',
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildTableCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: PdfColors.black,
        ),
      ),
    );
  }

  Future<pw.MemoryImage> _loadImage() async {
    final image = (await rootBundle.load('lib/assets/logo_1024.png'))
        .buffer
        .asUint8List();
    return pw.MemoryImage(image);
  }

  String _formatNumber(double value) {
    final numberFormat = NumberFormat('#,###.##');
    return numberFormat.format(value);
  }
}
