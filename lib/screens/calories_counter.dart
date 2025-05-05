import 'package:flutter/material.dart';

class CaloriesCounterScreen extends StatelessWidget {
  const CaloriesCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF141313), // Match DashboardScreen background
      child: Center(
        child: Text(
          "Calories Counter Page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}