import 'package:amortization_calculator_app/screens/auth/register_screen.dart';
import 'package:amortization_calculator_app/screens/home_screen.dart';
import 'package:amortization_calculator_app/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _obscurePassText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with login
      Get.off(() => HomeScreen()); // Use Get.off to remove the login screen from the navigation stack
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 60.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/logo-transparent-png.png',
                  height: 150.0,
                ),
                SizedBox(height: 24.0),
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Understand Your Repayment Plan.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF94364a),
                  ),
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
                        nextFocusNode: _passwordFocusNode,
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
                      // SizedBox(height: 24.0),
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
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _login, // Call _login function
                      child: Text('Login', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF94364a), // Button color
                        minimumSize: Size(double.infinity, 50), // Make button full-width
                      ),
                    ),
                    SizedBox(height: 12.0), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        Get.to(()=>RegisterScreen());
                      },
                      child: Text('Create Account', style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFe1e2e2), // Button color
                        minimumSize: Size(double.infinity, 50), // Make button full-width
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
