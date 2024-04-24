import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile/user_preferences.dart';
import 'package:social_media_app/components/profile_widget.dart';
// import 'package:social_media_app/components/user.dart';
import 'package:social_media_app/components/numbers_widget.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = AuthenticationService.auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.photoURL ?? '',
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
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.displayName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? '',
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
              // user.bio ?? '',
              '',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
