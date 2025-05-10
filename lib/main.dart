
// }
import 'package:elevate_fit/screens/dashboard_screen.dart';
import 'package:elevate_fit/screens/home_screen.dart';
import 'package:elevate_fit/screens/login_screen.dart';
import 'package:elevate_fit/screens/profile_screen.dart';
import 'package:elevate_fit/screens/signup_screen.dart';
import 'package:elevate_fit/screens/splash_screen.dart';
import 'package:elevate_fit/screens/workout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const SplashScreen()
          : const HomeScreen(),
      routes: {
        'login': (context) => const LoginScreen(),
        'signup': (context) => const SignupScreen(),
        'homebar': (context) => const HomeScreen(),
        'homescreen': (context) => const DashboardScreen(),
        'profilescreen': (context) => const UserProfile(),
      }
    );
  }
}

