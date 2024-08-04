import 'package:flutter/material.dart';
import 'package:amortization_calculator_app/widgets/drop_down_widget.dart';
import 'package:amortization_calculator_app/widgets/text_form_widget.dart';
import '../controller/leasing_screen_controller.dart';
import '../../../constants/enums.dart';
import '../../auth/services/logout_service.dart';

class LeasingScreen extends StatefulWidget {
  const LeasingScreen({super.key});

  @override
  State<LeasingScreen> createState() => _LeasingScreenState();
}

class _LeasingScreenState extends State<LeasingScreen> {
  final LeasingScreenController _leasingScreenController = LeasingScreenController();

  @override
  void initState() {
    super.initState();
    _leasingScreenController.assetCostController.addListener(() => setState(() {}));
    _leasingScreenController.amountFinancedController.addListener(() => setState(() {}));
    _leasingScreenController.numberOfRentalsController
        .addListener(() => setState(() {}));
    _leasingScreenController.marginInterestRateController
        .addListener(() => setState(() {}));
    _leasingScreenController.gracePeriodController.addListener(() => setState(() {}));
    _leasingScreenController.residualAmountController.addListener(() => setState(() {}));
    _leasingScreenController.advanceArrearsEnum = AdvanceArrearsEnum.advance;
  }

  @override
  void dispose() {
    _leasingScreenController.assetCostController.dispose();
    _leasingScreenController.amountFinancedController.dispose();
    _leasingScreenController.numberOfRentalsController.dispose();
    _leasingScreenController.gracePeriodController.dispose();
    _leasingScreenController.residualAmountController.dispose();
    _leasingScreenController.marginInterestRateFocusNode.dispose();
    _leasingScreenController.assetCostFocusNode.dispose();
    _leasingScreenController.amountFinancedFocusNode.dispose();
    _leasingScreenController.numberOfRentalsFocusNode.dispose();
    _leasingScreenController.gracePeriodFocusNode.dispose();
    _leasingScreenController.residualAmountFocusNode.dispose();
    _leasingScreenController.submitFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                scrolledUnderElevation: 0.0,
                backgroundColor: Colors.white,
                elevation: 0.5,
                shadowColor: Colors.black,
                centerTitle: true,
                title: Image.asset(
                  'lib/assets/logo-transparent-png.png',
                  height: 60.0,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    // Add padding here
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      // Logout icon
                      onPressed: () async {
                        LogoutService logoutService = LogoutService();
                        await logoutService.logout();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text:const TextSpan(
                    text: 'Leasing ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF970032),
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Calculator',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Divider(
                  height: 20,
                  thickness: 2,
                  indent: 150,
                  endIndent: 150,
                  color: Color(0xFF94364a),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _leasingScreenController.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextFormWidget(
                            labelText: "Asset Cost",
                            hintText: "EGP",
                            controller: _leasingScreenController.assetCostController,
                            focusNode: _leasingScreenController.assetCostFocusNode,
                            nextFocusNode:
                            _leasingScreenController.amountFinancedFocusNode,
                            icon: Icons.money_outlined,
                            isNumeric: true,
                            isDouble: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              double? assetCost = double.tryParse(value);
                              double? amountFinanced = double.tryParse(_leasingScreenController.amountFinancedController.text);
                              if (assetCost == null) {
                                return 'Invalid Asset Cost';
                              }
                              if (amountFinanced != null && assetCost < amountFinanced) {
                                return 'Asset Cost must be at least as Amount Financed';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Amount Financed *",
                            hintText: "EGP",
                            controller:
                            _leasingScreenController.amountFinancedController,
                            focusNode: _leasingScreenController.amountFinancedFocusNode,
                            nextFocusNode:
                            _leasingScreenController.numberOfRentalsFocusNode,
                            icon: Icons.account_balance_wallet,
                            isNumeric: true,
                            isDouble: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Please enter Amount Financed';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Number Of Rentals *",
                            hintText: "12",
                            controller:
                            _leasingScreenController.numberOfRentalsController,
                            focusNode: _leasingScreenController.numberOfRentalsFocusNode,
                            nextFocusNode:
                            _leasingScreenController.marginInterestRateFocusNode,
                            icon: Icons.format_list_numbered,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null) {
                                return 'Please enter Number Of Rentals';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Interest Rate *",
                            hintText: "0.5",
                            controller:
                            _leasingScreenController.marginInterestRateController,
                            focusNode:
                            _leasingScreenController.marginInterestRateFocusNode,
                            nextFocusNode: _leasingScreenController.gracePeriodFocusNode,
                            icon: Icons.percent,
                            isNumeric: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Please enter margin interest rate';
                              }
                              return null;
                            },
                            isDouble: true,
                          ),
                          TextFormWidget(
                            labelText: "Grace Period *",
                            hintText: "No G.P",
                            controller: _leasingScreenController.gracePeriodController,
                            focusNode: _leasingScreenController.gracePeriodFocusNode,
                            nextFocusNode:
                            _leasingScreenController.residualAmountFocusNode,
                            icon: Icons.timer,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null) {
                                return 'Please enter Grace Period';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Residual Amount *",
                            hintText: "EGP",
                            controller:
                            _leasingScreenController.residualAmountController,
                            focusNode: _leasingScreenController.residualAmountFocusNode,
                            nextFocusNode: _leasingScreenController.submitFocusNode,
                            icon: Icons.account_balance,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  double.tryParse(value) == null) {
                                return 'Please enter Residual Amount';
                              }
                              return null;
                            },
                          ),
                          DropdownWidget(
                            value: _leasingScreenController.valueChoose,
                            items: _leasingScreenController.listItem,
                            labelText: 'Rental Per Year',
                            onChanged: (val) {
                              setState(() {
                                _leasingScreenController.valueChoose = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.advance,
                                  groupValue:
                                  _leasingScreenController.advanceArrearsEnum,
                                  title:
                                      'in ${AdvanceArrearsEnum.advance.name}',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.arrears,
                                  groupValue:
                                  _leasingScreenController.advanceArrearsEnum,
                                  title:
                                      'in ${AdvanceArrearsEnum.arrears.name}',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.calculate,
                                  color: Colors.white),
                              onPressed: _leasingScreenController.isLoading
                                  ? null
                                  : () async {
                                      if (_leasingScreenController.formKey.currentState
                                              ?.validate() ??
                                          false) {
                                        setState(() {
                                          _leasingScreenController.isLoading = true;
                                        });
                                        await _leasingScreenController.calculate();
                                        setState(() {
                                          _leasingScreenController.isLoading = false;
                                        });
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:  const Color(0xFF148C79)
                              ),
                              label: const Text(
                                'Calculate',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_leasingScreenController.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioTile({
    required AdvanceArrearsEnum value,
    required AdvanceArrearsEnum? groupValue,
    required String title,
  }) {
    return RadioListTile<AdvanceArrearsEnum>(
      contentPadding: const EdgeInsets.all(0.0),
      value: value,
      tileColor: const Color(0xFF148C79),
      activeColor: Colors.white,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5.5,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      groupValue: groupValue,
      onChanged: (val) {
        setState(() {
          _leasingScreenController.advanceArrearsEnum = val;
        });
      },
    );
  }
}
