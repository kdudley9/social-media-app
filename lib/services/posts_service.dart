import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostsService {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('User Posts');

  Future<void> addPost(String message) {
    return posts.add({
      'Username': user!.displayName,
      'Message': message,
      'Timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPosts() {
    final postsStream = FirebaseFirestore.instance
        .collection('User Posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postsStream;
  }
}