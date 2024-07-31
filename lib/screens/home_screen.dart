import 'package:flutter/material.dart';
import 'package:amortization_calculator_app/widgets/drop_down_widget.dart';
import 'package:amortization_calculator_app/widgets/text_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/calc_controller.dart';
import '../enums.dart';
import '../services/logout_service.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalcController _calcController = CalcController();
  final _formKey = GlobalKey<FormState>();
  bool isConnected = false;
  String name = "";
  bool _isLoading = false;

  bool? _checkBox = false;
  String? _valueChoose = "4";
  final List<String> _listItem = ["4", "6", "12", "24", "36"];
  AdvanceArrearsEnum? _advanceArrearsEnum;
  final _marginInterestRateController = TextEditingController();
  final _assetCostController = TextEditingController();
  final _amountFinancedController = TextEditingController();
  final _numberOfRentalsController = TextEditingController();
  final _gracePeriodController = TextEditingController(text: '0');
  final _residualAmountController = TextEditingController(text: '0');

  final _marginInterestRateFocusNode = FocusNode();
  final _assetCostFocusNode = FocusNode();
  final _amountFinancedFocusNode = FocusNode();
  final _numberOfRentalsFocusNode = FocusNode();
  final _gracePeriodFocusNode = FocusNode();
  final _residualAmountFocusNode = FocusNode();
  final _submitFocusNode = FocusNode();

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('userName') ?? 'User';
    final gender = prefs.getString('gender') ?? 'Mr.';
    setState(() {
      name = '${gender == 'MALE' ? 'Mr.' : 'Mrs.'} $username';
    });
  }

  @override
  void initState() {
    super.initState();
    _assetCostController.addListener(() => setState(() {}));
    _amountFinancedController.addListener(() => setState(() {}));
    _numberOfRentalsController.addListener(() => setState(() {}));
    _marginInterestRateController.addListener(() => setState(() {}));
    _gracePeriodController.addListener(() => setState(() {}));
    _residualAmountController.addListener(() => setState(() {}));
    _advanceArrearsEnum = AdvanceArrearsEnum?.advance;
    _loadUserInfo();
  }

  @override
  void dispose() {
    _assetCostController.dispose();
    _amountFinancedController.dispose();
    _numberOfRentalsController.dispose();
    _gracePeriodController.dispose();
    _residualAmountController.dispose();
    _marginInterestRateFocusNode.dispose();
    _assetCostFocusNode.dispose();
    _amountFinancedFocusNode.dispose();
    _numberOfRentalsFocusNode.dispose();
    _gracePeriodFocusNode.dispose();
    _residualAmountFocusNode.dispose();
    _submitFocusNode.dispose();

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
                    padding: const EdgeInsets.only(right: 16.0), // Add padding here
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black), // Logout icon
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
                      key: _formKey,
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
                                  text: name,
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
                            controller: _assetCostController,
                            focusNode: _assetCostFocusNode,
                            nextFocusNode: _amountFinancedFocusNode,
                            icon: Icons.attach_money,
                            isNumeric: true,
                            isDouble: true,
                            validator: (value) {
                              //no validator need
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Amount Financed *",
                            hintText: "EGP",
                            controller: _amountFinancedController,
                            focusNode: _amountFinancedFocusNode,
                            nextFocusNode: _numberOfRentalsFocusNode,
                            icon: Icons.account_balance_wallet,
                            isNumeric: true,
                            isDouble: true,
                            validator: (value) {
                              if (value == null || value.isEmpty || double.tryParse(value) == null) {
                                return 'Please enter Amount Financed';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Number Of Rentals *",
                            hintText: "12",
                            controller: _numberOfRentalsController,
                            focusNode: _numberOfRentalsFocusNode,
                            nextFocusNode: _marginInterestRateFocusNode,
                            icon: Icons.format_list_numbered,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                return 'Please enter Number Of Rentals';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Margin Interest Rate *",
                            hintText: "0.5",
                            controller: _marginInterestRateController,
                            focusNode: _marginInterestRateFocusNode,
                            nextFocusNode: _gracePeriodFocusNode,
                            icon: Icons.percent,
                            isNumeric: true,
                            validator: (value) {
                              if (value == null || value.isEmpty || double.tryParse(value) == null) {
                                return 'Please enter margin interest rate';
                              }
                              return null;
                            },
                            isDouble: true,
                          ),
                          TextFormWidget(
                            labelText: "Grace Period *",
                            hintText: "No G.P",
                            controller: _gracePeriodController,
                            focusNode: _gracePeriodFocusNode,
                            nextFocusNode: _residualAmountFocusNode,
                            icon: Icons.timer,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null || value.isEmpty || int.tryParse(value) == null) {
                                return 'Please enter Grace Period';
                              }
                              return null;
                            },
                          ),
                          TextFormWidget(
                            labelText: "Residual Amount *",
                            hintText: "EGP",
                            controller: _residualAmountController,
                            focusNode: _residualAmountFocusNode,
                            nextFocusNode: _submitFocusNode,
                            icon: Icons.account_balance,
                            isNumeric: true,
                            isDouble: false,
                            validator: (value) {
                              if (value == null || value.isEmpty || double.tryParse(value) == null) {
                                return 'Please enter Residual Amount';
                              }
                              return null;
                            },
                          ),
                          DropdownWidget(
                            value: _valueChoose,
                            items: _listItem,
                            labelText: 'Rental Per Year',
                            onChanged: (val) {
                              setState(() {
                                _valueChoose = val;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            title: const Text("Start from this month?"),
                            value: _checkBox,
                            onChanged: (val) {
                              setState(() {
                                _checkBox = val;
                              });
                            },
                            activeColor: Color(0xFF94364a),
                            checkColor: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.advance,
                                  groupValue: _advanceArrearsEnum,
                                  title: AdvanceArrearsEnum.advance.name,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildRadioTile(
                                  value: AdvanceArrearsEnum.arrears,
                                  groupValue: _advanceArrearsEnum,
                                  title: AdvanceArrearsEnum.arrears.name,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.calculate, color: Colors.white),
                              onPressed: _isLoading ? null : () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  await _calcController.calculate(
                                    amountFinance: double.parse(_amountFinancedController.text),
                                    assetCost: double.parse(_assetCostController.text),
                                    interestRate: double.parse(_marginInterestRateController.text),
                                    gracePeriod: double.parse(_gracePeriodController.text),
                                    effectiveRate: double.parse(_marginInterestRateController.text),
                                    noOfRental: int.parse(_valueChoose!),
                                    rentalInterval: int.parse(_numberOfRentalsController.text),
                                    beginning: (_advanceArrearsEnum == AdvanceArrearsEnum.advance) ? true : false,
                                    residualValue: double.parse(_residualAmountController.text),
                                    startFromFirstMonth: _checkBox!,
                                  );

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF94364a),
                              ),
                              label: Text(
                                'Start Now',
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
          if (_isLoading)
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
      contentPadding: EdgeInsets.all(0.0),
      value: value,
      tileColor: Color(0xFFe05170),
      activeColor: Colors.white,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.5)),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      groupValue: groupValue,
      onChanged: (val) {
        setState(() {
          _advanceArrearsEnum = val;
        });
      },
    );
  }
}