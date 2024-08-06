import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/title_widget.dart';
import '../controller/leasing_controller.dart';
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
                const SizedBox(height: 20),
                const Center(
                  child: TitleWidget(
                    firstText: 'Leasing ',
                    secondText: 'Calculator',
                  ),
                ),
                const SizedBox(height: 20),
                const CustomDividerWidget(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
