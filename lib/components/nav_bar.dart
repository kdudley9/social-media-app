import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home/home_content.dart';
import 'package:social_media_app/pages/add_post/add_post.dart';
import 'package:social_media_app/pages/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final currentUser = FirebaseAuth.instance.currentUser;

  int _navIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  final List<Widget> _screens = [
    const HomeContent(),
    const AddPostPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedItemColor: const Color(0xffcc0000),
        unselectedItemColor: const Color.fromARGB(255, 204, 204, 204),
        onTap: _onNavTapped,
      ),
      body: _screens[_navIndex],
    );
  }
}
