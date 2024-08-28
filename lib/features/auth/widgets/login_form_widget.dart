import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/text_form_widget.dart';
import '../screens/register_screen.dart';

class LoginFormWidget extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormWidget(
            labelText: 'Name',
            hintText: 'Enter your name',
            controller: _loginController.nameController,
            focusNode: _loginController.nameFocusNode,
            nextFocusNode: _loginController.passwordFocusNode,
            icon: Icons.person,
            isNumeric: false,
            validator: (value) => validateName(value),
            isDouble: false,
          ),
          SizedBox(height: 5.h,),
          Obx(
                () => TextFormField(
              focusNode: _loginController.passwordFocusNode,
              obscureText: _loginController.obscurePassText.value,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              controller: _loginController.passwordController,
              validator: (value) => validatePassword(value),
              decoration: InputDecoration(
                hintText: "Enter Your Password",
                suffixIcon: GestureDetector(
                  onTap: _loginController.togglePasswordVisibility,
                  child: Icon(
                    _loginController.obscurePassText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                prefixIcon: const Icon(Icons.lock),

                labelText: "Password",
                contentPadding: EdgeInsets.symmetric(vertical: 22.h),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Obx(
                () => Column(
              children: [
                ElevatedButton(
                  onPressed: _loginController.isLoading.value
                      ? null
                      : _loginController.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _loginController.isLoading.value
                        ? Colors.grey
                        : const Color(0xFFe0516f),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: Text(
                    _loginController.isLoading.value
                        ? 'Logging in...'
                        : 'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe1e2e2),
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
