import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/register_controller.dart';
import '../../widgets/text_form_widget.dart';

enum IndividualCompanyEnum { Individual, Company }

enum GenderEnum { Male, Female }

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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
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
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildRadioTile(
                            value: IndividualCompanyEnum.Individual,
                            groupValue: _individualCompanyEnum,
                            title: IndividualCompanyEnum.Individual.name,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildRadioTile(
                            value: IndividualCompanyEnum.Company,
                            groupValue: _individualCompanyEnum,
                            title: IndividualCompanyEnum.Company.name,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          return 'the password must be at least 6 ';
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
                        onPressed: () {
                            print('presed');
                            _register();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF94364a), // Button color
                          minimumSize: Size(
                              double.infinity, 50), // Make button full-width
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      _registerController.registerUser(
        firstName: 'omdaar',
        lastName: 'kenafadwi', // Add the respective controllers for these fields
        userName: nameController.text,
        email: emailController.text,
        password: _passwordTextController.text,
        phoneNumber: phoneController.text,
        gender: _genderEnum==GenderEnum.Male?'MALE':'FEMALE',
        userType: _individualCompanyEnum == IndividualCompanyEnum.Individual
            ? 'INDIVIDUAL'
            : 'COMPANY',
      );
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
      tileColor: Color(0xFFe05170),
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
        setState(() {
          _individualCompanyEnum = value;
        });
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
      tileColor: Color(0xFFe05170),
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
        setState(() {
          _genderEnum = value;
        });
      },
    );
  }
}
