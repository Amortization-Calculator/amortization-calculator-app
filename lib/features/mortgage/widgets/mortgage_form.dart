import 'package:amortization_calculator/features/mortgage/widgets/slider_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../../../widgets/text_form_widget.dart';
import '../controllers/mortgage_controller.dart';
import '../widgets/result_widget.dart';

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
                  labelText: "Unit Price *",
                  hintText: "EGP",
                  controller: controller.unitPriceController,
                  focusNode: controller.unitPriceFocusNode,
                  nextFocusNode: controller.downPaymentForTheUnitFocusNode,
                  icon: Icons.home,
                  isNumeric: true,
                  isDouble: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || double.tryParse(value) == null) {
                      return 'Please enter a valid unit price';
                    }
                    return null;
                  },
                ),
                TextFormWidget(
                  labelText: "Down Payment for the Unit *",
                  hintText: "EGP",
                  controller: controller.downPaymentForTheUnitController,
                  focusNode: controller.downPaymentForTheUnitFocusNode,
                  nextFocusNode: controller.interestRateFocusNode,
                  icon: Icons.money,
                  isNumeric: true,
                  isDouble: true,
                  validator: (value) => downPaymentForTheUnit(value, controller.unitPriceController),
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
                Obx(() => SliderContainerWidget(
                  sliderValue: controller.sliderValue.value,
                  onValueChanged: controller.updateSliderValue,
                )),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => ResultWidget(
            financeAmount: controller.financeAmount.value,
            name: 'Financing Amount',
          )),
          const SizedBox(height: 10),
          Obx(() => ResultWidget(
            financeAmount: controller.monthlyInstallment.value,
            name: 'Monthly Installment',
          )),
          const SizedBox(height: 10),
          Obx(() => ResultWidget(
            financeAmount: (controller.monthlyInstallment.round() * 100 / 50),
            name: 'Expected Salary',
          ),),
        ],
      ),
    );
  }
}
