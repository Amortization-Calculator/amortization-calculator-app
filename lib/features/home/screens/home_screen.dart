import 'package:flutter/material.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/title_widget.dart';
import '../widgets/service_card_widget.dart';
import '../widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeTextWidget(),
              SizedBox(height: 20),
              Center(
                child: TitleWidget(
                  firstText: 'Calc ',
                  secondText: 'Amortization',
                ),
              ),
              SizedBox(height: 20),
              CustomDividerWidget(),
              SizedBox(height: 20),
              Text(
                'Choose From Our Services',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              ServiceCardWidget(
                title: 'Leasing Calculator',
                iconPath: 'lib/assets/leasing.png',
                page: '/LeasingScreen',
              ),
              SizedBox(height: 10),
              ServiceCardWidget(
                title: 'Mortgage Calculator',
                iconPath: 'lib/assets/mortage.png',
                page: '/MortgageScreen',
              ),
              SizedBox(height: 10),
              ServiceCardWidget(
                title: 'Team',
                iconPath: 'lib/assets/team.png',
                page: '/TeamScreen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
