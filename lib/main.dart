import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/pages/registration/welcome_page.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:social_media_app/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
            .copyWith(background: AppColors.minglWhite),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: AppColors.minglRed),
            foregroundColor: AppColors.minglRed,
            fixedSize: const Size(250, 50),
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
