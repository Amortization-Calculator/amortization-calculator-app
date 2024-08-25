import 'package:flutter/material.dart';
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
