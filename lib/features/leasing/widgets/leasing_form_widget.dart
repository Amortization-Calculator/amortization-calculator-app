import 'package:flutter/material.dart';
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          TextFormWidget(
            labelText: "Number Of Rentals *",
            hintText: "12",
            controller: controller.numberOfRentalsController,
            focusNode: controller.numberOfRentalsFocusNode,
            nextFocusNode: controller.marginInterestRateFocusNode,
            icon: Icons.format_list_numbered,
            isNumeric: true,
            isDouble: false,
            validator: validateNumberOfRentals,
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          DropdownWidget(
            value: controller.valueChoose,
            items: controller.listItem,
            labelText: 'Rental Per Year',
            onChanged: (val) => controller.valueChoose = val,
          ),
          const SizedBox(height: 10),
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
                const SizedBox(width: 10),
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
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate, color: Colors.white),
              onPressed: controller.isLoading.value ? null : controller.onCalculateButtonPressed,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF148C79)),
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
