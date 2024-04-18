import 'package:flutter/material.dart';
import 'package:social_media_app/services/authentication_service.dart';

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
                  color: Color(0xffcc0000),
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffcc0000)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xfff2f2f2)),
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
                          await _authenticationService.logIn(
                            context,
                            _emailcontroller.text,
                            _passwordController.text,
                          );
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
