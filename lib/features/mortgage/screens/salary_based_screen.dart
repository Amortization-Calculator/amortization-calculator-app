import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../../../widgets/custom_result_button.dart';
import '../../../widgets/text_form_widget.dart';
import '../controllers/salary_based_controller.dart';
import '../services/pdf_service.dart';
import '../widgets/slider_container_widget.dart';
import '../widgets/result_widget.dart';

class SalaryBasedScreen extends StatelessWidget {
  SalaryBasedScreen({super.key});

  final controller = Get.put(MortgageBasedSalaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormWidget(
                      labelText: "Salary *",
                      hintText: "EGP",
                      controller: controller.salaryController,
                      focusNode: controller.salaryFocusNode,
                      nextFocusNode: controller.interestRateFocusNode,
                      icon: Icons.monetization_on_outlined,
                      isNumeric: true,
                      isDouble: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null) {
                          return 'Please enter a valid salary';
                        }
                        return null;
                      },
                    ),
                    TextFormWidget(
                      labelText: "Interest Rate *",
                      hintText: "5 %",
                      controller: controller.interestRateController,
                      focusNode: controller.interestRateFocusNode,
                      nextFocusNode: FocusNode(),
                      icon: Icons.percent,
                      isNumeric: true,
                      isDouble: false,
                      validator: validateInterestRate,
                    ),
                    Obx(
                      () => SliderContainerWidget(
                        sliderValue: controller.sliderValue.value,
                        onValueChanged: controller.updateSliderValue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => ResultWidget(
                  financeAmount: (controller.unitPrice.value),
                  name: 'Unit Price',
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => ResultWidget(
                  financeAmount: (controller.downPayment.value),
                  name: 'Down Payment',
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => ResultWidget(
                  financeAmount: (controller.amountFinance.value),
                  name: 'Amount Finance',
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => ResultWidget(
                  financeAmount: controller.monthlyInstallment.value,
                  name: 'Monthly Installment',
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => ResultWidget(
                  financeAmount: (controller.grossReceivable.value),
                  name: 'Gross Receivable',
                ),
              ),
              const SizedBox(height: 20),
              CustomResultButton(
                buttonText: 'Print & Save as PDF ',
                buttonColor: const Color(0xFFd32f2e),
                onPressed: () async {
                  final pdfService = PdfService(
                    duration: controller.sliderValue.value,
                    unitPrice: controller.unitPrice.value,
                    downPayment: controller.downPayment.value,
                    amountFinance: controller.amountFinance.value,
                    monthlyInstallment: controller.monthlyInstallment.value,
                    grossReceivable: controller.grossReceivable.value,
                    salary: double.tryParse(controller.salaryController.text) ??
                        0.0,
                    interestRate: controller.interestRateController.text,
                  );
                  await pdfService.generateAndSharePdf();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
