import 'package:flutter/material.dart';
import 'package:social_media_app/services/authentication_service.dart';
import 'package:social_media_app/themes/app_colors.dart';
import 'package:social_media_app/components/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        backgroundColor: AppColors.minglRed,
        foregroundColor: AppColors.minglWhite,
      ),
      body: Column(
        children: [
          // Displaying user greeting
          Container(
            alignment: Alignment.center,
            //padding: const EdgeInsets.all(16),
            child: Text(
              'Hello ${AuthenticationService.auth.currentUser?.displayName ?? "Guest"}',
              style: const TextStyle(fontSize: 20),
            ),
          ),

          // Expanded allows the list view to take the remaining space
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("Timestamp", descending: true) // Show newest posts first
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Building a list of posts
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length, // Define number of items
                    itemBuilder: (context, index) {
                      // Get the individual post
                      final post = snapshot.data!.docs[index];
                      return Post(
                        message: post['Message'],
                        user: post['UserEmail'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(), // Loading indicator while fetching data
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
