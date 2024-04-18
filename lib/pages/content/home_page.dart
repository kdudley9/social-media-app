import 'package:flutter/material.dart';
import 'package:social_media_app/themes/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Feed'),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
      ),
    );
  }
}
