import 'package:flutter/material.dart';
import 'package:social_media_app/exception_handlers/auth_exception_handler.dart';
import 'package:social_media_app/pages/home/home_page.dart';
import 'package:social_media_app/pages/registration/reset_password_page.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationService _authenticationService = AuthenticationService();

  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.minglRed,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Log into your account',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 100),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'example@gmail.com',
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPasswordPage()),
                          );
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.minglRed),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.minglWhite),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(350, 50),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final _status = await _authenticationService.logIn(
                              _emailcontroller.text.trim(),
                              _passwordController.text.trim(),
                            );
                            if (_status == AuthStatus.successful) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            } else {
                              final error =
                                  AuthExceptionHandler.generateErrorMessage(
                                      _status);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(error)));
                            }
                          }
                        },
                        child: const Text('LOG IN'),
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
}
