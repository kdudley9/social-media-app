import 'package:flutter/material.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';

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
                color: AppColors.minglRed,
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
              ),
            ),
            const SizedBox(height: 75.0),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              child: const Text("Log In"),
            ),
            const SizedBox(height: 25.0),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'signup');
              },
              child: const Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
