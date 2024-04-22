import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile/user_preferences.dart';
import 'package:social_media_app/components/profile_widget.dart';
import 'package:social_media_app/components/user.dart';
import 'package:social_media_app/components/textfield.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  void saveUser() {
  if (user.id == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User ID is not set")),
    );
    return;
  }

  // Update user data in the database
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('users').doc(user.id);

  userDoc.update({
    'name': user.name,
    'email': user.email,
    'bio': user.bio,
  }).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error updating profile: $error")),
    );
  });
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
        ),
        body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: ListView (
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
                onClicked: () async {},
              ),

              const SizedBox (height: 24),
              
              TextFieldWidget(
                label: 'Name',
                text: user.name,
                onChanged: (name) {},
              ),

              const SizedBox (height: 24),
              
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),

              const SizedBox (height: 24),
              
              TextFieldWidget(
                label: 'Bio',
                text: user.bio,
                maxLines: 5,
                onChanged: (bio) {},
              ),

              const SizedBox(height: 24),

              OutlinedButton(
                onPressed: saveUser,
                // () {
                //   //print("Profile saved!");
                // },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.minglRed, // Text color
                  side: const BorderSide(color: AppColors.minglRed), // Outline color
                ),
                child: const Text("Save"),
              ),

            ],
          ),
        )
    );
  }
}