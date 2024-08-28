import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/title_widget.dart';
import '../controllers/leasing_controller.dart';
import '../../../widgets/loading_overlay_widget.dart';
import '../../../widgets/custom_appBar_widget.dart';
import '../../../widgets/custom_divider_widget.dart';
import '../widgets/leasing_form_widget.dart';

class LeasingScreen extends StatelessWidget {
  LeasingScreen({super.key});
  final LeasingController controller = Get.put(LeasingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LeasingController>(
        builder: (controller) => Stack(
          children: [
            Column(
              children: [
                const CustomAppBar(),
                SizedBox(height: 20.h),
                 Center(
                  child: TitleWidget(
                    firstText: 'Leasing ',
                    secondText: 'Calculator',
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomDividerWidget(),
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      child: LeasingForm(controller: controller),
                    ),
                  ),
                ),
              ],
            ),
            LoadingOverlayWidget(isLoading: controller.isLoading),
          ],
        ),
      ),
    );
  }
}
