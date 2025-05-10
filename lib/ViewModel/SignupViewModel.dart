import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupViewModel {
  Future<void> signUp(BuildContext context, String email, String password,String firstName,String phone,String username) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'firstName': firstName,
          'email': email,
          'phone': phone,
          'username': username,
        });
      }
      print("sign up");
      Navigator.pushReplacementNamed(context, 'login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrorDialog(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showErrorDialog(context, 'The account already exists for that email.');
      } else {
        _showErrorDialog(context, 'Sign up failed: ${e.message}');
      }
    } catch (e) {
      _showErrorDialog(context, 'An unexpected error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Validators
  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter a name';
    return null;
  }

  String? validateNumber(String? v) {
    if (v == null || v.isEmpty) return 'Enter a number';
    return null;
  }

  String? validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Enter an email';
    if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Enter a password';
    if (v.length < 8) return 'Password too short';
    return null;
  }

  void navigation(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }
}