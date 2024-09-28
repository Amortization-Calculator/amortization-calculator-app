import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../../../constants/enums.dart';
import '../../../widgets/drop_down_widget.dart';
import '../../../widgets/generic_radio_tile_widget.dart';
import '../../../widgets/text_form_widget.dart';
import '../controllers/leasing_controller.dart';

class LeasingForm extends StatelessWidget {
  final LeasingController controller;

  const LeasingForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormWidget(
            labelText: "Amount Financed *",
            hintText: "EGP",
            controller: controller.amountFinancedController,
            focusNode: controller.amountFinancedFocusNode,
            nextFocusNode: controller.assetCostFocusNode,
            icon: Icons.account_balance_wallet,
            isNumeric: true,
            isDouble: true,
            validator: validateAmountFinanced,
          ),
          SizedBox(height: 10.h), // Responsive height
          TextFormWidget(
            labelText: "Asset Cost",
            hintText: "EGP",
            controller: controller.assetCostController,
            focusNode: controller.assetCostFocusNode,
            nextFocusNode: controller.numberOfRentalsFocusNode,
            icon: Icons.money_outlined,
            isNumeric: true,
            isDouble: true,
            validator: (value) => validateAssetCost(value, controller.amountFinancedController),
          ),
          SizedBox(height: 10.h), // Responsive height
          TextFormWidget(
            labelText: "Number Of Years *",
            hintText: "3",
            controller: controller.numberOfRentalsController,
            focusNode: controller.numberOfRentalsFocusNode,
            nextFocusNode: controller.marginInterestRateFocusNode,
            icon: Icons.format_list_numbered,
            isNumeric: true,
            isDouble: false,
            validator: (value){
              if (value == null || value.isEmpty || int.tryParse(value) == null) {
                return 'Please enter Number Of Years';
              }
              if(int.parse(value)>10){
                return 'Number of years must be at least 2 years';
              }
              if(int.parse(value)>10) {
                return 'Number of years can not be more than 10 years';
              }
              return null;
            },
          ),
          SizedBox(height: 10.h), // Responsive height
          TextFormWidget(
            labelText: "Interest Rate *",
            hintText: "5 %",
            controller: controller.marginInterestRateController,
            focusNode: controller.marginInterestRateFocusNode,
            nextFocusNode: controller.gracePeriodFocusNode,
            icon: Icons.percent,
            isNumeric: true,
            isDouble: false,
            validator: validateInterestRate,
          ),
          SizedBox(height: 10.h), // Responsive height
          TextFormWidget(
            labelText: "Grace Period *",
            hintText: "No G.P",
            controller: controller.gracePeriodController,
            focusNode: controller.gracePeriodFocusNode,
            nextFocusNode: controller.residualAmountFocusNode,
            icon: Icons.timer,
            isNumeric: true,
            isDouble: false,
            validator: validateGracePeriod,
          ),
          SizedBox(height: 10.h), // Responsive height
          TextFormWidget(
            labelText: "Residual Amount *",
            hintText: "EGP",
            controller: controller.residualAmountController,
            focusNode: controller.residualAmountFocusNode,
            nextFocusNode: controller.submitFocusNode,
            icon: Icons.account_balance,
            isNumeric: true,
            isDouble: false,
            validator: validateResidualAmount,
          ),
          SizedBox(height: 10.h), // Responsive height
          DropdownWidget(
            value: controller.valueChoose,
            items: controller.listItem,
            labelText: 'Rental Per Year',
            onChanged: (val) => controller.valueChoose = val,
          ),
          SizedBox(height: 10.h), // Responsive height
          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: GenericRadioTileWidget<AdvanceArrearsEnum>(
                    value: AdvanceArrearsEnum.advance,
                    groupValue: controller.advanceArrearsEnum.value,
                    title: 'in ${AdvanceArrearsEnum.advance.name}',
                    onChanged: (val) {
                      controller.advanceArrearsEnum.value = val;
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: GenericRadioTileWidget<AdvanceArrearsEnum>(
                    value: AdvanceArrearsEnum.arrears,
                    groupValue: controller.advanceArrearsEnum.value,
                    title: 'in ${AdvanceArrearsEnum.arrears.name}',
                    onChanged: (val) {
                      controller.advanceArrearsEnum.value = val;
                    },
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 10.h),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate, color: Colors.white),
              onPressed: controller.isLoading.value ? null : controller.onCalculateButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF970032),
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w), // Responsive padding
              ),
              label: const Text(
                'Calculate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
