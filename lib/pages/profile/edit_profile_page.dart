import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/profile_widget.dart';
import 'package:social_media_app/components/textfield.dart';
import 'package:social_media_app/providers/profile_image_provider.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

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
      _usernameController.text = userData['username'] ?? '';
      _bioController.text = userData['bio'] ?? '';
    });
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
      'username': _usernameController.text,
      'email': user.email,
      'bio': _bioController.text,
    };

    if (_image != null) {
      final imageUrl = await _uploadImageToStorage(_image!);
      userData['imagePath'] = imageUrl;

      Provider.of<ProfileImageProvider>(context, listen: false)
          .setProfileImageUrl(imageUrl);
    } else {
      await userDoc.set(userData, SetOptions(merge: true));
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved')));
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}.jpg';
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
              imagePath: user.photoURL ?? '',
              isEdit: true,
              onClicked: () async {
                await _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Username',
              text: user.displayName ?? '',
              controller: _usernameController,
              onChanged: (username) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Bio',
              text: '',
              controller: _bioController,
              maxLines: 5,
              onChanged: (bio) {},
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: _saveUser,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.minglRed,
                side: const BorderSide(color: AppColors.minglRed),
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
