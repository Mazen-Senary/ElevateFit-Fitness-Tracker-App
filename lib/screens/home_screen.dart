
import 'package:elevate_fit/screens/calories_counter.dart';
import 'package:elevate_fit/screens/workout_screen.dart';
import 'package:elevate_fit/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of screens to switch between
  final List<Widget> _screens = [
    DashboardScreen(),
    WorkoutsPage(),
    CaloriesCounterScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch to the selected screen
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue.shade300,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Workouts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            label: "Calories Counter",
          ),
        ],
      ),
    );
  }
}