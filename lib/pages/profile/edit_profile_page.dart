import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/pages/profile/user_preferences.dart';
import 'package:social_media_app/components/profile_widget.dart';
// import 'package:social_media_app/components/user.dart';
import 'package:social_media_app/components/textfield.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;
  File? _image;

  @override
  void initState() {
    super.initState();
    user = AuthenticationService.auth.currentUser!;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveUser() async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(user.uid);

    final userData = {
      'useranme': user.displayName,
      'email': user.email,
      // 'bio': user!.bio,
    };

    if (_image != null) {
      final imageUrl = await _uploadImageToStorage(_image!);
      userData['imagePath'] = imageUrl;
      user.updatePhotoURL(imageUrl);

      await userDoc.set(userData, SetOptions(merge: true));
    } else {
      await userDoc.set(userData, SetOptions(merge: true));
    }
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);
      await ref.putFile(imageFile);

      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
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
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              // imagePath: user.imagePath,
              imagePath: user.photoURL ?? '',
              isEdit: true,
              onClicked: () async {
                await _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Name',
              text: user.displayName ?? '',
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Email',
            //   text: user.email,
            //   onChanged: (email) {},
            // ),
            // const SizedBox(height: 24),
            // TextFieldWidget(
            //   label: 'Bio',
            //   text: user.bio,
            //   maxLines: 5,
            //   onChanged: (bio) {},
            // ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: _saveUser,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.minglRed, // Text color
                side: const BorderSide(
                    color: AppColors.minglRed), // Outline color
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
