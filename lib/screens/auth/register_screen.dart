import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/register_controller.dart';
import '../../enums.dart';
import '../../widgets/text_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  IndividualCompanyEnum? _individualCompanyEnum =
      IndividualCompanyEnum.Individual;
  GenderEnum? _genderEnum = GenderEnum.Male;

  final RegisterController _registerController = Get.put(RegisterController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
  TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscurePassText = true;
  bool _obscureConfirmPassText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isLoading ? () async => false : () async => true,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          elevation: 0.5,
          shadowColor: Colors.black,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's create your account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Divider(
                      height: 20,
                      thickness: 2,
                      indent: 150,
                      endIndent: 150,
                      color: Color(0xFF94364a),
                    ),
                    SizedBox(height: 24.0),
                    Form(
                      key: _formKey,
                      child: AbsorbPointer(
                        absorbing: _isLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormWidget(
                              labelText: 'Name',
                              hintText: 'Enter your name',
                              controller: nameController,
                              focusNode: nameFocusNode,
                              nextFocusNode: emailFocusNode,
                              icon: Icons.person,
                              isNumeric: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              isDouble: false,
                            ),
                            TextFormWidget(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              controller: emailController,
                              focusNode: emailFocusNode,
                              nextFocusNode: phoneFocusNode,
                              icon: Icons.email,
                              isNumeric: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                const emailPattern =
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$';
                                final regExp = RegExp(emailPattern);
                                if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              isDouble: false,
                            ),
                            TextFormWidget(
                              labelText: 'Phone Number',
                              hintText: 'Enter your phone number',
                              controller: phoneController,
                              focusNode: phoneFocusNode,
                              nextFocusNode: _passwordFocusNode,
                              icon: Icons.phone,
                              isNumeric: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                const phonePattern = r'^01[0125][0-9]{8}$';
                                final regExp = RegExp(phonePattern);
                                if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              isDouble: false,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Account Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildRadioTile(
                                    value: IndividualCompanyEnum.Individual,
                                    groupValue: _individualCompanyEnum,
                                    title: 'Individual',
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: _buildRadioTile(
                                    value: IndividualCompanyEnum.Company,
                                    groupValue: _individualCompanyEnum,
                                    title: 'Company',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildRadioTileGender(
                                    value: GenderEnum.Male,
                                    groupValue: _genderEnum,
                                    title: 'Male',
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: _buildRadioTileGender(
                                    value: GenderEnum.Female,
                                    groupValue: _genderEnum,
                                    title: 'Female',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: _obscurePassText,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordTextController,
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'The password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Your Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePassText = !_obscurePassText;
                                    });
                                  },
                                  child: Icon(
                                    _obscurePassText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Password",
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text('* password must be as 1A@a2 '),
                            SizedBox(height: 20),
                            TextFormField(
                              obscureText: _obscureConfirmPassText,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _confirmPasswordTextController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordTextController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Confirm Your Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureConfirmPassText =
                                      !_obscureConfirmPassText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureConfirmPassText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Confirm Password",
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isLoading
                                      ? Colors.grey
                                      : Color(0xFF148C79),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _registerController.registerUser(
          userName: nameController.text,
          email: emailController.text,
          password: _passwordTextController.text,
          phoneNumber: phoneController.text,
          gender: _genderEnum == GenderEnum.Male ? 'MALE' : 'FEMALE',
          userType: _individualCompanyEnum == IndividualCompanyEnum.Individual
              ? 'INDIVIDUAL'
              : 'COMPANY',
        );

        // Handle successful registration (e.g., navigate to another screen)
      } catch (error) {
        // Handle registration error
        print('Registration failed: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildRadioTile({
    required IndividualCompanyEnum value,
    required IndividualCompanyEnum? groupValue,
    required String title,
  }) {
    return RadioListTile<IndividualCompanyEnum>(
      contentPadding: EdgeInsets.all(0.0),
      value: value,
      tileColor: Color(0xFF148C79),
      activeColor: Colors.white,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.5)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      groupValue: groupValue,
      onChanged: (IndividualCompanyEnum? value) {
        if (!_isLoading) {
          setState(() {
            _individualCompanyEnum = value;
          });
        }
      },
    );
  }

  Widget _buildRadioTileGender({
    required GenderEnum value,
    required GenderEnum? groupValue,
    required String title,
  }) {
    return RadioListTile<GenderEnum>(
      contentPadding: EdgeInsets.all(0.0),
      value: value,
      tileColor: Color(0xFF148C79),
      activeColor: Colors.white,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.5)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      groupValue: groupValue,
      onChanged: (GenderEnum? value) {
        if (!_isLoading) {
          setState(() {
            _genderEnum = value;
          });
        }
      },
    );
  }
}
