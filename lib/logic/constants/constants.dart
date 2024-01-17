import 'package:flutter/material.dart';

class Constants {
  static const String addPost = 'Add Post';
  static const Color primaryColor = Colors.black87;
  static ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
  );
}