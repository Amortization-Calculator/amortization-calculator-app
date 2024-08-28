import 'package:flutter/material.dart';
import '../widgets/mortgage_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MortgageScreen extends StatelessWidget {
  const MortgageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: const MortgageForm(),
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
