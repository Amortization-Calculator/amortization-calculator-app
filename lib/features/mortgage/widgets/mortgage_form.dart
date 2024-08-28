import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../validators.dart';
import '../../../widgets/custom_result_button.dart';
import '../../../widgets/pop_up_alert_dialog.dart';
import '../../../widgets/text_form_widget.dart';
import '../controllers/mortgage_controller.dart';
import '../services/mortgage_by_unit_price_pdf_service.dart';
import '../widgets/result_widget.dart';
import '../widgets/slider_container_widget.dart';

class MortgageForm extends StatelessWidget {
  const MortgageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MortgageController());

    return Form(
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
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0.w, 0.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormWidget(
                  labelText: "Unit Price *",
                  hintText: "EGP",
                  controller: controller.unitPriceController,
                  focusNode: controller.unitPriceFocusNode,
                  nextFocusNode: controller.downPaymentForTheUnitFocusNode,
                  icon: Icons.home,
                  isNumeric: true,
                  isDouble: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a valid unit price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFormWidget(
                  labelText: "Down Payment for the Unit *",
                  hintText: "EGP",
                  controller: controller.downPaymentForTheUnitController,
                  focusNode: controller.downPaymentForTheUnitFocusNode,
                  nextFocusNode: controller.interestRateFocusNode,
                  icon: Icons.money,
                  isNumeric: true,
                  isDouble: true,
                  validator: (value) => downPaymentForTheUnit(
                      value, controller.unitPriceController),
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
              financeAmount: controller.financeAmount.value,
              name: 'Financing Amount',
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => ResultWidget(
              financeAmount: controller.monthlyInstallment.value,
              name: 'Monthly Installment',
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => ResultWidget(
              financeAmount: (controller.monthlyInstallment.round() * 100 / 50),
              name: 'Expected Salary',
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => ResultWidget(
              financeAmount: (controller.grossReceivable.value),
              name: 'Gross Receivable',
            ),
          ),
          SizedBox(height: 20.h),
          CustomResultButton(
            buttonText: 'Print & Save as PDF ',
            buttonColor: const Color(0xFFd32f2e),
            onPressed: () async {
              // Validate the form
              if (controller.formKey.currentState?.validate() ?? false) {
                final double unitPrice =
                    double.tryParse(controller.unitPriceController.text) ?? 0.0;
                final double downPayment = double.tryParse(
                        controller.downPaymentForTheUnitController.text) ??
                    0.0;

                final pdfService = MortgageByUnitPricePdfService(
                  salary: controller.monthlyInstallment.round() * 100 / 50,
                  duration: controller.sliderValue.value,
                  amountFinance: controller.financeAmount.value,
                  grossReceivable: controller.grossReceivable.value,
                  interestRate: controller.interestRateController.text,
                  monthlyInstallment: controller.monthlyInstallment.value,
                  unitPrice: unitPrice,
                  downPayment: downPayment,
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
    );
  }
}
