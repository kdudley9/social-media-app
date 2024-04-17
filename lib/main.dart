import 'package:flutter/material.dart';
import 'package:social_media_app/pages/registration/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
            .copyWith(background: const Color(0xfff2f2f2)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: Color(0xffcc0000)),
            foregroundColor: const Color(0xffcc0000),
            fixedSize: const Size(250, 50),
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
