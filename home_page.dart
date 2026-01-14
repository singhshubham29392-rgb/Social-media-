import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_post_button.dart';
import 'package:socialmedia/components/my_textfield.dart';
import '../components/my_drawer.dart';
import '../components/my_listtile.dart';
import '../database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;

      // ✅ FIX: correct method name
      database.postMessage(message);

      // ✅ clear textfield
      newPostController.clear();
    }
  }

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // input row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: "Say Something...",
                    controller: newPostController,
                    obscureText: false,
                  ),
                ),
                const SizedBox(width: 10),
                MyPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          // posts list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                // ❌ error
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }

                // ⏳ loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final posts = snapshot.data!.docs;

                if (posts.isEmpty) {
                  return const Center(
                    child: Text("No posts yet"),
                  );
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['Timestamp'];

                    return MyListtile(
                      title: message,
                      subtitle: userEmail,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

