import 'package:flutter/material.dart';

import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../../home/widgets/welcome_text_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
     body:
     Padding(
       padding: EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           WelcomeTextWidget(),
           SizedBox(height: 20),
           CustomDividerWidget(),
         ],
       ),
     ),

    );
  }
}
