import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_button.dart';
import 'package:socialmedia/components/my_textfield.dart';
import '../helper/helper_function.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // ✅ WAIT for login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // close loader
      if (mounted) Navigator.pop(context);

      // ✅ NAVIGATE ONLY ON SUCCESS
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomePage()),
      );

    } on FirebaseAuthException catch (e) {
      if (mounted) Navigator.pop(context);
      displayMessagetoUser(e.code, context);
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
                Icon(Icons.person, size: 80, color: colors.inversePrimary),
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

                const SizedBox(height: 25),

                MyButton(
                  text: "Log In",
                  onTap: login,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
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
