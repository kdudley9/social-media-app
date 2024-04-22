import 'package:flutter/material.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/pages/home/home_content.dart'; 
import 'package:social_media_app/pages/add_post/add_post.dart';
import 'package:social_media_app/pages/profile/profile_page.dart';
import 'package:social_media_app/pages/profile/edit_profile_page.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the user 
  final currentUser = FirebaseAuth.instance.currentUser;

  int _navIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  final List<Widget> _screens = [
    const HomeContent(), // Use the new HomeContent widget
    const AddPostPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Feed'),
      //   backgroundColor: AppColors.minglRed,
      //   foregroundColor: AppColors.minglWhite,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _navIndex,
        selectedItemColor: Color(0xffcc0000),
        unselectedItemColor: Color.fromARGB(255, 204, 204, 204),
        onTap: _onNavTapped,
      ),
      body: _screens[_navIndex], // Use the new screens list to switch
    );
  }
}
