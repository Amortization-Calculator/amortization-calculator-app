
import 'package:flutter/material.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/title_widget.dart';
import '../../leasing/screens/leasing_screen.dart';
import '../../mortgage/screens/mortgage_screen.dart';
import '../widgets/service_card_widget.dart';
import '../widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeTextWidget(),
              const SizedBox(height: 20),
              const Center(
                child:
                TitleWidget(firstText: 'Calc ', secondText: 'Amortization'),
              ),
              const SizedBox(height: 20),
              const CustomDividerWidget(),
              const SizedBox(height: 20),
              const Text(
                'Choose From Our Services',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              ServiceCardWidget(
                title: 'Leasing Calculator',
                iconPath: 'lib/assets/leasing.png',
                page: LeasingScreen(),
              ),
              const SizedBox(height: 10),
              const ServiceCardWidget(
                title: 'Mortgage Calculator',
                iconPath: 'lib/assets/mortage.png',
                page: MortgageScreen(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
