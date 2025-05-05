
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      _showErrorDialog(context, 'Please enter a valid email address.');
      return;
    }
    if (password.isEmpty || password.length < 8) {
      _showErrorDialog(context, 'Password must be at least 8 characters.');
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Success message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Successful'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      navigation(context, 'homebar');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed. Please try again.';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      }

      _showErrorDialog(context, errorMessage);
    } catch (e) {
      _showErrorDialog(context, 'An unexpected error occurred.');
    }
  }
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );

  }
  // bool checkFields(TextEditingController email, TextEditingController pass, BuildContext context)
  // {
  //   if (email.text.contains("@") && email.text.contains(".") && pass.text.length >= 8) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login Successful'),
  //         backgroundColor: Colors.green,
  //         duration: Duration(seconds: 1),
  //       ),
  //     );
  //     return true;
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to login'),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 1),
  //       ),
  //     );
  //     return false;
  //   }
  // }

}


