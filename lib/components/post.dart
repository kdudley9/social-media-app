import 'package:flutter/material.dart';
import 'package:social_media_app/shared_assets/app_colors.dart';
import 'package:social_media_app/components/like_button.dart';
import 'package:social_media_app/components/comment_button.dart';
import 'package:social_media_app/components/comment.dart';
import 'package:social_media_app/components/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final String time;
  final List<String> likes;
  
  const Post({
    super.key,
    required this.message,
    required this.user,
    required this.postID,
    required this.likes,
    required this.time,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // Toggle like/unlike functionality
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Access the document in Firestore
    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.postID);

    if (isLiked) {
      // Add current user's email to 'Likes'
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      // Remove current user's email from 'Likes'
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }



  void addComment(String commentText) {
    FirebaseFirestore.instance
    .collection("User Posts")
    .doc(widget.postID)
    .collection("Comments")
    .add({
      "Comment": commentText,
      "Commenter": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  } 



  void showCommentDialog () {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        //title: Text("Reply to post"),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(
            hintText: "Add a comment...",
            // border: OutlineInputBorder(),
            // labelText: "Enter your comment",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: const Text("Post"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
              },
            child: const Text("Cancel"),
          ),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.user,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.minglRed,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.message,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.left, // Ensures text wraps correctly
          ),
          
          const SizedBox(height: 15),


          Row(
            children: [
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              const SizedBox(width: 10), 
              Text(
                widget.likes.length.toString(),
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(width: 35), 

              CommentButton(
                onTap: showCommentDialog,
              ),
              const SizedBox(width: 10),
              Text(
                '0',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),


          // display comments
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postID)
            .collection("Comments")
            .orderBy("CommentTime", descending: true)
            .snapshots(), 
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData = doc.data() as Map<String, dynamic>;
                  return Comment(
                    message: commentData["Comment"],  
                    time: formatDate(commentData["CommentTime"]),
                    user: commentData["Commenter"],
                    );
                }).toList(),

              );
            },
          )



        ],
      ),
    );
  }
}
