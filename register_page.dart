import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmedia/components/my_button.dart';
import 'package:socialmedia/components/my_textfield.dart';
import '../helper/helper_function.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void register() async {
    // show loading circle
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // check password match
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayMessagetoUser("passwords don't match", context);
      return;
    } else {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

      // create user in firestore

      await createUserDocument(userCredential);

      // pop loading
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomePage()),
      );

      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessagetoUser(e.code, context);
      }
    }
  }

  // create user document in firestore
  Future<void> createUserDocument(UserCredential userCredential) async {
    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: colors.inversePrimary,
                ),

                const SizedBox(height: 25),

                Text(
                  "S O C I A L  M E D I A",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),

                const SizedBox(height: 30),

                MyTextfield(
                  hintText: "Username",
                  controller: usernameController,
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextfield(
                  hintText: "Email",
                  controller: emailController,
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextfield(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                MyTextfield(
                  hintText: "Confirm Password",
                  controller: confirmPwController,
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                MyButton(
                  text: "Register",
                  onTap: register,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
