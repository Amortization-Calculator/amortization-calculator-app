import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../widgets/text_form_widget.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final LoginController _loginController =  Get.put(LoginController());
  final TextEditingController _passwordTextController = TextEditingController();
  bool _obscurePassText = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _loginController.loginUser(
          userName: nameController.text,
          password: _passwordTextController.text,
        );
      } catch (error) {
        print('Login failed: $error');

      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: _obscurePassText,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordTextController,
                              validator: (value) {
                                if (value == null || value.length < 6) {
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
                            SizedBox(height: 50.0),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: _isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isLoading
                                        ? Colors.grey
                                        : Color(0xFF94364a),
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  child: Text(
                                    _isLoading ? 'Logging in...' : 'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => RegisterScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFe1e2e2),
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
    );
  }
}
