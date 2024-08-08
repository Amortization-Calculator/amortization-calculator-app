import 'package:flutter/material.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../../widgets/title_widget.dart';
import '../widgets/mortgage_form.dart';

class MortgageScreen extends StatelessWidget {
  const MortgageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppBar(),
              SizedBox(height: 20),
              Center(
                child: TitleWidget(
                  firstText: 'Mortgage ',
                  secondText: 'Calculator',
                ),
              ),
              SizedBox(height: 20),
              CustomDividerWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MortgageForm(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
