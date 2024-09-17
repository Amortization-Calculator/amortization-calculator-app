import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../validators.dart';
import '../../../widgets/custom_result_button.dart';
import '../../../widgets/pop_up_alert_dialog.dart';
import '../../../widgets/text_form_widget.dart';
import '../controllers/salary_based_controller.dart';
import '../services/mortgage_by_salary_pdf_service.dart';
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
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        spreadRadius: 1.w,
                        blurRadius: 1.w,
                        offset: Offset(0.w, 1.h),
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
                        validator: validateSalary,
                      ),
                      SizedBox(height: 10.h),
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
                      SizedBox(height: 10.h),
                      Obx(
                        () => SliderContainerWidget(
                          sliderValue: controller.sliderValue.value,
                          onValueChanged: controller.updateSliderValue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => ResultWidget(
                    value: controller.isValid.value
                        ? controller.unitPrice.value
                        : 0,
                    name: 'Unit Price',
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => ResultWidget(
                    value: controller.isValid.value
                        ? controller.downPayment.value
                        : 0,
                    name: 'Down Payment',
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => ResultWidget(
                    value: controller.isValid.value
                        ? controller.amountFinance.value
                        : 0,
                    name: 'Amount Finance',
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => ResultWidget(
                    value: controller.isValid.value
                        ? controller.monthlyInstallment.value
                        : 0,
                    name: 'Monthly Installment',
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => ResultWidget(
                    value: controller.isValid.value
                        ? controller.grossReceivable.value
                        : 0,
                    name: 'Gross Receivable',
                  ),
                ),
                SizedBox(height: 20.h),
                CustomResultButton(
                  buttonText: 'Print & Save as PDF',
                  buttonColor: const Color(0xFFd32f2e),
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      final pdfService = MortgageBySalaryPdfService(
                        duration: controller.sliderValue.value,
                        unitPrice: controller.unitPrice.value,
                        downPayment: controller.downPayment.value,
                        amountFinance: controller.amountFinance.value,
                        monthlyInstallment: controller.monthlyInstallment.value,
                        grossReceivable: controller.grossReceivable.value,
                        salary:
                            double.tryParse(controller.salaryController.text) ??
                                0.0,
                        interestRate: controller.interestRateController.text,
                      );
                      await pdfService.generateAndSharePdf();
                    } else {
                      Get.dialog(
                        const PopUpAlertDialog(
                          title: ("Error"),
                          content: 'Please Enter Valid Input',
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
