import 'package:amortization_calculator/features/mortgage/screens/salary_based_screen.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_appBar_widget.dart';
import 'mortgage_screen.dart';

class ChooseServiceScreen extends StatefulWidget {
  const ChooseServiceScreen({super.key});

  @override
  _ChooseServiceScreenState createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = const [
    Tab(text: 'By Unit Price'),
    Tab(text: 'By Salary'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tabController: _tabController,
        showTabs: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const MortgageScreen(),
          SalaryBasedScreen(),
        ],
      ),
    );
  }
}