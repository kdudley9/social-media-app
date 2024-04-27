import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostsService {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('User Posts');

  // Add a new post with a default empty "Likes" list
  Future<void> addPost(String message) {
    return posts.add({
      'Username': user?.displayName ?? 'Unknown User',
      'Message': message,
      'Timestamp': Timestamp.now(),
      'Likes': <String>[], // Default empty list for likes
    });
  }

  // Get the stream of posts ordered by timestamp
  Stream<QuerySnapshot> getPosts() {
    final postsStream = posts
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postsStream;
  }

  // Function to add a "like" to a specific post
  Future<void> addLike(String postId) async {
    final postRef = posts.doc(postId);
    await postRef.update({
      'Likes': FieldValue.arrayUnion([user!.uid]), // Add current user's UID to the likes
    });
  }

  // Function to remove a "like" from a specific post
  Future<void> removeLike(String postId) async {
    final postRef = posts.doc(postId);
    await postRef.update({
      'Likes': FieldValue.arrayRemove([user!.uid]), // Remove current user's UID from the likes
    });
  }
}
