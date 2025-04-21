import 'package:elevate_fit/screens/login_screen.dart';
import 'package:elevate_fit/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',  // Initial route
      routes: {
        'login': (context) =>  LoginScreen(),
        'signup': (context) => const SignupScreen(),
      },
      //home:LoginScreen()
    );
  }
}
