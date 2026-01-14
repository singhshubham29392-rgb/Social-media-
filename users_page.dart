import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_listtile.dart';
import 'package:socialmedia/helper/helper_function.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Page"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          // ❌ error
          if (snapshot.hasError) {
            displayMessagetoUser("Something went wrong", context);
            return const Center(
              child: Text("Failed to load users"),
            );
          }

          // ⏳ loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ✅ data available
          final users = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    //get data from each user
                    String username = user['username'];
                    String email = user['email'];

                    return MyListtile(
                        title: username,
                        subtitle: email,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

