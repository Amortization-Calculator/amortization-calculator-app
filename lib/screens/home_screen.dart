import 'package:flutter/material.dart';
import 'package:amortization_calculator_app/widgets/drop_down_widget.dart';
import 'package:amortization_calculator_app/widgets/text_form_widget.dart';
import '../controller/home_controller.dart';
import '../enums.dart';
import '../services/logout_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _homeController.assetCostController.addListener(() => setState(() {}));
    _homeController.amountFinancedController.addListener(() => setState(() {}));
    _homeController.numberOfRentalsController
        .addListener(() => setState(() {}));
    _homeController.marginInterestRateController
        .addListener(() => setState(() {}));
    _homeController.gracePeriodController.addListener(() => setState(() {}));
    _homeController.residualAmountController.addListener(() => setState(() {}));
    _homeController.advanceArrearsEnum = AdvanceArrearsEnum?.advance;
    _homeController.loadUserInfo();
  }

  @override
  void dispose() {
    _homeController.assetCostController.dispose();
    _homeController.amountFinancedController.dispose();
    _homeController.numberOfRentalsController.dispose();
    _homeController.gracePeriodController.dispose();
    _homeController.residualAmountController.dispose();
    _homeController.marginInterestRateFocusNode.dispose();
    _homeController.assetCostFocusNode.dispose();
    _homeController.amountFinancedFocusNode.dispose();
    _homeController.numberOfRentalsFocusNode.dispose();
    _homeController.gracePeriodFocusNode.dispose();
    _homeController.residualAmountFocusNode.dispose();
    _homeController.submitFocusNode.dispose();

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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _homeController.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Welcome ',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xFF970032),
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: _homeController.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Calc ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF970032),
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Amortization',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          const Center(
                            child: Divider(
                              height: 20,
                              thickness: 2,
                              indent: 150,
                              endIndent: 150,
                              color: Color(0xFF94364a),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormWidget(
                            labelText: "Asset Cost",
                            hintText: "EGP",
                            controller: _homeController.assetCostController,
                            focusNode: _homeController.assetCostFocusNode,
                            nextFocusNode:
                                _homeController.amountFinancedFocusNode,
                            icon: Icons.money_outlined,
                            isNumeric: true,
                            isDouble: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              double? assetCost = double.tryParse(value);
                              double? amountFinanced = double.tryParse(_homeController.amountFinancedController.text);
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
                                _homeController.amountFinancedController,
                            focusNode: _homeController.amountFinancedFocusNode,
                            nextFocusNode:
                                _homeController.numberOfRentalsFocusNode,
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
                                _homeController.numberOfRentalsController,
                            focusNode: _homeController.numberOfRentalsFocusNode,
                            nextFocusNode:
                                _homeController.marginInterestRateFocusNode,
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
                                _homeController.marginInterestRateController,
                            focusNode:
                                _homeController.marginInterestRateFocusNode,
                            nextFocusNode: _homeController.gracePeriodFocusNode,
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
                            controller: _homeController.gracePeriodController,
                            focusNode: _homeController.gracePeriodFocusNode,
                            nextFocusNode:
                                _homeController.residualAmountFocusNode,
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
                                _homeController.residualAmountController,
                            focusNode: _homeController.residualAmountFocusNode,
                            nextFocusNode: _homeController.submitFocusNode,
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
                            value: _homeController.valueChoose,
                            items: _homeController.listItem,
                            labelText: 'Rental Per Year',
                            onChanged: (val) {
                              setState(() {
                                _homeController.valueChoose = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          // CheckboxListTile(
                          //   contentPadding: const EdgeInsets.all(0.0),
                          //   title: const Text("Start from this month?"),
                          //   value: _homeController.checkBox,
                          //   onChanged: (val) {
                          //     setState(() {
                          //       _homeController.checkBox = val;
                          //     });
                          //   },
                          //   activeColor: Color(0xFF94364a),
                          //   checkColor: Colors.white,
                          // ),
                          // const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.advance,
                                  groupValue:
                                      _homeController.advanceArrearsEnum,
                                  title:
                                      'in ' + AdvanceArrearsEnum.advance.name,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.arrears,
                                  groupValue:
                                      _homeController.advanceArrearsEnum,
                                  title:
                                      'in ' + AdvanceArrearsEnum.arrears.name,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.calculate,
                                  color: Colors.white),
                              onPressed: _homeController.isLoading
                                  ? null
                                  : () async {
                                      if (_homeController.formKey.currentState
                                              ?.validate() ??
                                          false) {
                                        setState(() {
                                          _homeController.isLoading = true;
                                        });
                                        await _homeController.calculate();
                                        setState(() {
                                          _homeController.isLoading = false;
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
          if (_homeController.isLoading)
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
      tileColor: Color(0xFF148C79),
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
          _homeController.advanceArrearsEnum = val;
        });
      },
    );
  }
}
