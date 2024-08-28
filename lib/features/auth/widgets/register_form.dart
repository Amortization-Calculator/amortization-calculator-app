import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../validators.dart';
import '../../../widgets/generic_radio_tile_widget.dart';
import '../../../widgets/text_form_widget.dart';
import '../../../constants/enums.dart';
import '../controllers/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());

    return Form(
      key: registerController.formKey,
      child: AbsorbPointer(
        absorbing: registerController.isLoading.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormWidget(
              labelText: 'Name',
              hintText: 'Enter your name',
              controller: registerController.nameController,
              focusNode: registerController.nameFocusNode,
              nextFocusNode: registerController.emailFocusNode,
              icon: Icons.person,
              isNumeric: false,
              isDouble: false,
              validator: (value) => validateName(value),
            ),
            SizedBox(height: 5.h),
            TextFormWidget(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: registerController.emailController,
              focusNode: registerController.emailFocusNode,
              nextFocusNode: registerController.phoneFocusNode,
              icon: Icons.email,
              isNumeric: false,
              isDouble: false,
              validator: (value) => validateEmail(value),
            ),
            SizedBox(height: 5.h),
            TextFormWidget(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              controller: registerController.phoneController,
              focusNode: registerController.phoneFocusNode,
              nextFocusNode: registerController.passwordFocusNode,
              icon: Icons.phone,
              isNumeric: true,
              isDouble: false,
              validator: (value) => validatePhoneNumber(value),
            ),
            SizedBox(height: 5.h),
            Text(
              'Account Type',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: GenericRadioTileWidget<IndividualCompanyEnum>(
                      value: IndividualCompanyEnum.Individual,
                      title: 'Individual',
                      groupValue: registerController.individualCompanyEnum.value,
                      onChanged: (IndividualCompanyEnum? value) {
                        registerController.individualCompanyEnum.value = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GenericRadioTileWidget<IndividualCompanyEnum>(
                      value: IndividualCompanyEnum.Company,
                      title: 'Company',
                      groupValue: registerController.individualCompanyEnum.value,
                      onChanged: (IndividualCompanyEnum? value) {
                        registerController.individualCompanyEnum.value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Gender',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: GenericRadioTileWidget<GenderEnum>(
                      value: GenderEnum.Male,
                      title: 'Male',
                      groupValue: registerController.genderEnum.value,
                      onChanged: (GenderEnum? value) {
                        registerController.genderEnum.value = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GenericRadioTileWidget<GenderEnum>(
                      value: GenderEnum.Female,
                      title: 'Female',
                      groupValue: registerController.genderEnum.value,
                      onChanged: (GenderEnum? value) {
                        registerController.genderEnum.value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Obx(
                  () => TextFormField(
                focusNode: registerController.passwordFocusNode,
                obscureText: registerController.obscurePassText.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                controller: registerController.passwordTextController,
                validator: (value) => validatePassword(value),
                decoration: InputDecoration(
                  hintText: "Enter Your Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      registerController.obscurePassText.value ^= true;
                    },
                    child: Icon(
                      registerController.obscurePassText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  labelText: "Password",
                  contentPadding: EdgeInsets.symmetric(vertical: 22.h),

                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp, // Responsive font size
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Obx(
                  () => TextFormField(
                    obscureText: registerController.obscureConfirmPassText.value,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    controller: registerController.confirmPasswordTextController,
                    validator: (value) => validateConfirmPassword(
                        value, registerController.passwordTextController.text),
                    decoration: InputDecoration(
                      hintText: "Confirm Your Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          registerController.obscureConfirmPassText.value ^= true;
                        },
                        child: Icon(
                          registerController.obscureConfirmPassText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      labelText: "Confirm Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 22.h),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  )

            ),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                onPressed: registerController.isLoading.value
                    ? null
                    : registerController.registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: registerController.isLoading.value
                      ? Colors.grey
                      : const Color(0xFFe0516f),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
