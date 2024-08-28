import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
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
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeTextWidget(),
              SizedBox(height: 20.h),
              const Center(
                child: TitleWidget(
                  firstText: 'Calc ',
                  secondText: 'Amortization',
                ),
              ),
              SizedBox(height: 20.h),
              CustomDividerWidget(),
              SizedBox(height: 20.h),
              Text(
                'Choose From Our Services',
                style: TextStyle(fontSize: 22.sp),
              ),
              SizedBox(height: 20.h),
              const ServiceCardWidget(
                title: 'Leasing Calculator',
                iconPath: 'lib/assets/leasing.png',
                page: '/LeasingScreen',
              ),
              SizedBox(height: 10.h),
              const ServiceCardWidget(
                title: 'Mortgage Calculator',
                iconPath: 'lib/assets/mortage.png',
                page: '/ChooseServiceScreen',
              ),
              SizedBox(height: 10.h),
              const ServiceCardWidget(
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
