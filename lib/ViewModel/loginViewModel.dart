
import 'package:flutter/material.dart';

class LoginViewModel {
  void navigation(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  String? validateEmail(String? v) {
    if (v == null || v.isEmpty)  return 'Enter an email';
    if (!v.contains('@'))         return 'Invalid email';
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty)      return 'Enter a password';
    if (v.length < 8)                return 'Password too short';
    return null;
  }
  void checkFields(TextEditingController email, TextEditingController pass, BuildContext context) {
    // Check if the email contains @ and . and password is at least 8 characters
    if (email.text.contains("@") && email.text.contains(".") && pass.text.length >= 8) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Successful'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      navigation(context, 'signup');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
