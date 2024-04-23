import 'package:flutter/material.dart';
import 'package:social_media_app/pages/registration/login_page.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/services/posts_service.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:social_media_app/components/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final PostsService _postsService = PostsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        centerTitle: true,
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
        actions: [
          IconButton(
            onPressed: () async {
              await _authenticationService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          // Expanded allows the list view to take the remaining space
          Expanded(
            child: StreamBuilder(
              stream: _postsService.getPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Building a list of posts
                  return ListView.builder(
                    itemCount:
                        snapshot.data!.docs.length, // Define number of items
                    itemBuilder: (context, index) {
                      // Get the individual post
                      final post = snapshot.data!.docs[index];
                      return Post(
                        message: post['Message'],
                        user: post['Username'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child:
                        CircularProgressIndicator(), // Loading indicator while fetching data
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
