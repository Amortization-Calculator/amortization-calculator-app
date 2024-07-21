import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amortization_calculator_app/screens/result_screen.dart';
import 'package:amortization_calculator_app/widgets/drop_down_widget.dart';
import 'package:amortization_calculator_app/widgets/text_form_widget.dart';
import 'package:get/get.dart';

enum AdvanceArrearsEnum { advance, arrears }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isConnected = false;

  bool? _checkBox = false;
  String? _valueChoose = "4";
  final List<String> _listItem = ["4", "6", "12", "24"];
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

  @override
  void initState() {
    super.initState();

    _assetCostController.addListener(() => setState(() {}));
    _amountFinancedController.addListener(() => setState(() {}));
    _numberOfRentalsController.addListener(() => setState(() {}));
    _marginInterestRateController.addListener(() => setState(() {}));
    _gracePeriodController.addListener(() => setState(() {}));
    _residualAmountController.addListener(() => setState(() {}));
    _advanceArrearsEnum = AdvanceArrearsEnum.advance;
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
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Image.asset(
          'lib/assets/logo-transparent-png.png',
          height: 60.0,
        ),
      ),
      body: SingleChildScrollView(
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
                    style: TextStyle(
                      fontSize: (22),
                      color: Color(0xFF970032),
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Mr. Omar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                Center(
                  child: Divider(
                    height: 20,
                    thickness: 2,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFF94364a),
                  ),
                ),
                SizedBox(height: 10),
                TextFormWidget(
                  labelText: "Asset Cost",
                  hintText: "EGP",
                  controller: _assetCostController,
                  focusNode: _assetCostFocusNode,
                  nextFocusNode: _amountFinancedFocusNode,
                  icon: Icons.attach_money,
                  isDouble: false,
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
                  isDouble: false,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
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
                  isDouble: false,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return 'Please enter Number Of Rentals';
                    }
                    return null;
                  },
                ),

                TextFormWidget(
                  labelText: "margin interest rate *",
                  hintText: "0.5",
                  controller: _marginInterestRateController,
                  focusNode: _marginInterestRateFocusNode,
                  nextFocusNode: _gracePeriodFocusNode,
                  icon: Icons.percent,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return 'Please entermargin interest rate';
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
                  isDouble: false,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
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
                  isDouble: false,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
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
                SizedBox(height: 10),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  title: Text("Start from this month?"),
                  value: _checkBox,
                  onChanged: (val) {
                    setState(() {
                      _checkBox = val;
                    });
                  },
                  activeColor: Color(0xFF94364a),
                  checkColor: Colors.white,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildRadioTile(
                        value: AdvanceArrearsEnum.advance,
                        groupValue: _advanceArrearsEnum,
                        title: AdvanceArrearsEnum.advance.name,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildRadioTile(
                        value: AdvanceArrearsEnum.arrears,
                        groupValue: _advanceArrearsEnum,
                        title: AdvanceArrearsEnum.arrears.name,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.calculate, color: Colors.white),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_assetCostController.text.isEmpty) {
                          _assetCostController.text =
                              _amountFinancedController.text;
                        }
                        Get.to(()=>ResultScreen());
                        //       builder: (context) => ResultScreen()),
                        // );
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
