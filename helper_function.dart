import 'package:flutter/material.dart';

void displayMessagetoUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AboutDialog(
        children: [
          Text(message),
        ],
      )
  );
}