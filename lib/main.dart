import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/pages/add_post/add_post.dart';
import 'package:social_media_app/pages/home/home_content.dart';
import 'package:social_media_app/components/nav_bar.dart';
import 'package:social_media_app/pages/profile/edit_profile_page.dart';
import 'package:social_media_app/pages/profile/profile_page.dart';
import 'package:social_media_app/pages/registration/login_page.dart';
import 'package:social_media_app/pages/registration/reset_password_page.dart';
import 'package:social_media_app/pages/registration/signup_page.dart';
import 'package:social_media_app/pages/registration/welcome_page.dart';
import 'package:social_media_app/providers/profile_image_provider.dart';
import 'package:social_media_app/providers/user_data_provider.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      routes: {
        'home-content': (context) => const HomeContent(),
        'add-post': (context) => const AddPostPage(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignupPage(),
        'reset-password': (context) => const ResetPasswordPage(),
        'welcome': (context) => const WelcomePage(),
        'edit-profile': (context) => const EditProfilePage(),
        'profile': (context) => const ProfilePage(),
        'nav-bar': (context) => const NavBar(),
      },
    );
  }
}
