import 'package:flutter/material.dart';
import 'package:social_media_app/pages/registration/login_page.dart';
import 'package:social_media_app/pages/registration/signup_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MINGL',
              style: TextStyle(
                color: Color(0xffcc0000),
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
              ),
            ),
            const SizedBox(height: 75.0),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text("Log In"),
            ),
            const SizedBox(height: 25.0),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
