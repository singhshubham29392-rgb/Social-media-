import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextfield({super.key, required this.hintText, required this.controller,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      obscureText: obscureText,
    );
  }
}
