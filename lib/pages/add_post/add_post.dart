import 'package:flutter/material.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:social_media_app/nav.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Post"),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
        ),
    );
  }
}