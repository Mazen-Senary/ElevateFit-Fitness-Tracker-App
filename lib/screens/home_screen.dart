import 'package:elevate_fit/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginScreen loginScreen = LoginScreen();
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3C72),
                Color(0xff008080),
                Color(0xFF121212),
              ],
            ),
          ),
        ),
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.white,size: 30,)),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.person),color: Colors.white,),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
           setState(() {
             myIndex=index;
           });
        },
          currentIndex: myIndex,
        backgroundColor: Colors.blue.shade300,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Workouts"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ]),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Welcome back, User",
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700
                ),),
            ),
            Center(child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 10,
              animation: true,
              animationDuration: 1200,
              percent: 0.7,
              center: Text("70%"),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey,
            ))
          ],
        ),
      ),
    );
  }
}
