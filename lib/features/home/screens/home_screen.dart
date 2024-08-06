import 'package:amortization_calculator_app/features/leasing/screens/leasing_screen.dart';
import 'package:amortization_calculator_app/widgets/custom_appBar_widget.dart';
import 'package:amortization_calculator_app/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/title_widget.dart';
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
              title: 'Leasing',
              iconPath: 'lib/assets/leasing.png',
              page: LeasingScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
