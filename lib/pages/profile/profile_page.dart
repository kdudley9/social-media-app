import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile/user_preferences.dart';
import 'package:social_media_app/components/profile_widget.dart';
import 'package:social_media_app/components/user.dart';
import 'package:social_media_app/components/numbers_widget.dart';
import 'package:social_media_app/themes/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Navigator.pushNamed(context, 'edit-profile');
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 50),
          const NumbersWidget(),
          const SizedBox(height: 50),
          buildAbout(user),
        ]),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
