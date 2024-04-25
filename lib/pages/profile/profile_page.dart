import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile/user_preferences.dart';
import 'package:social_media_app/components/profile_widget.dart';
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
  late String bio = '';
  late String username = '';

  @override
  void initState() {
    super.initState();
    user = AuthenticationService.auth.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final userData = await userDoc.get();
    setState(() {
      bio = userData['bio'] ?? '';
      username = userData['username'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
              // imagePath: user.photoURL ?? '',
              userId: user.uid,
              onClicked: () async {
                Navigator.pushNamed(context, 'edit-profile');
              },
            ),
            const SizedBox(height: 24),
            buildName(),
            const SizedBox(height: 50),
            const NumbersWidget(),
            const SizedBox(height: 50),
            buildAbout(),
          ],
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildAbout() => Container(
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
              bio,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
