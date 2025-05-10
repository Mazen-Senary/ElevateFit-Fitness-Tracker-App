
import 'package:elevate_fit/screens/calories_counter.dart';
import 'package:elevate_fit/screens/profile_screen.dart';
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


  final List<Widget> _screens = [
    DashboardScreen(),
    WorkoutsPage(),
    CaloriesCounterScreen(),
    UserProfile(),

    //UserProfile(imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ASunflower_from_Silesia2.jpg&psig=AOvVaw2C1jjWzgKLggx7CxUy3NMC&ust=1746941257104000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOjzq7uVmI0DFQAAAAAdAAAAABAE', displayName:'mazen' , username: "mazen", email: 'mazen', phone: '2342424254254', location: 'alexandria'),
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
            _currentIndex = index; // Switch screen
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