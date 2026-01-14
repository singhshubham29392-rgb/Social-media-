import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // collection of posts
  final CollectionReference posts =
  FirebaseFirestore.instance.collection('posts');

  // post a message
  Future<void> postMessage(String message) async {
    await posts.add({
      'UserEmail': currentUser!.email,
      'PostMessage': message,
      'Timestamp': Timestamp.now(),
    });
  }
  //read posts from firestore
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();
    return postStream;
  }
}

