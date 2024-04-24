// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:axnoltest/model/services/auth_services.dart';
import 'package:axnoltest/view/profile_screen.dart';
import 'package:axnoltest/view/widgets/constant_height.dart';
import 'package:axnoltest/view/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    final AuthService authService = AuthService();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SHREE ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "IRA",
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 160, 40),
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const Text(
                "EDUCATION",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),
              const ConstantHeight(size: 0.04),
              CustomTextFieldWidget(
                controller: emailController,
                label: "Email address *",
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return "Enter Valid Email";
                  } else {
                    return null;
                  }
                },
              ),
              const ConstantHeight(size: 0.02),
              CustomTextFieldWidget(
                controller: passwordController,
                label: "Password *",
                validator: (value) {
                  if (value!.length < 6) {
                    return "Password is Incorrect";
                  } else {
                    return null;
                  }
                },
              ),
              const ConstantHeight(size: 0.02),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (loginKey.currentState!.validate()) {
                      log('Validation success');
                      Map<String, dynamic>? loginResult = await authService.login(
                        emailController.text,
                        passwordController.text,
                      );
                      log('Login Result: $loginResult');
                      if (loginResult != null) {
                        if (loginResult.containsKey('access_token')) {
                          log('Login successful');

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        } else if (loginResult.containsKey('error')) {
                          String errorMessage = loginResult['error'];
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login failed: $errorMessage'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login failed. Please try again.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Sign in'),
                ),
              ),
              const ConstantHeight(size: 0.08),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not registered yet? ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign Up now",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
