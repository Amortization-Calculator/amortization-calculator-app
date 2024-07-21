import 'package:flutter/material.dart';
import '../../widgets/text_form_widget.dart';

enum IndividualCompanyEnum { Individual, Company }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  IndividualCompanyEnum? _individualCompanyEnum=IndividualCompanyEnum.Individual;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();
  bool _obscurePassText = true;
  bool _obscureConfirmPassText = true;

  IndividualCompanyEnum _selectedType = IndividualCompanyEnum.Individual;

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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 10),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      obscureText: _obscurePassText,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value == null || value.length < 7) {
                          return 'Please enter a valid password';
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
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                    SizedBox(height: 16),
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
                              _obscureConfirmPassText = !_obscureConfirmPassText;
                            });
                          },
                          child: Icon(
                            _obscureConfirmPassText
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                          if (_formKey.currentState!.validate()) {
                            // Implement your registration logic here
                            print('Register button pressed');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF94364a), // Button color
                          minimumSize: Size(double.infinity, 50), // Make button full-width
                        ),
                        // style: ElevatedButton.styleFrom(
                        //   // backgroundColor: Color(0xFF94364a),
                        //   // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        //   // shape: RoundedRectangleBorder(
                        //   //   borderRadius: BorderRadius.circular(5),
                        //   // ),
                        // ),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 16,color: Colors.white),
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
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      groupValue: groupValue,
      onChanged: (val) {
        setState(() {
          _individualCompanyEnum = val;
        });
      },
    );
  }
}
