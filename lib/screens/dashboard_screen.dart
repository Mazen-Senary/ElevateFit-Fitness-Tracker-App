
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_fit/ViewModel/steptracking.dart';
import 'package:elevate_fit/screens/dashboard_screen.dart';
import 'package:elevate_fit/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/custom_FAB.dart';
import '../Widgets/custom_drawer_widgets.dart';
import '../Widgets/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Progress percentage for circular percent
  double percentage = 1.0;
  int waterCounter = 0;
  int waterTarget = 8;
  bool showFAB = false;//for the customFab
  Color progressColor = Colors.red;
  String userName = "";//stores namme coming from firebase(firstname)
  late StepTracker stepTracker;//objexct to manage step counting
  int stepGoal = 6000;
  String _currentMode = 'heart';// menu screens

  @override
  void initState() {
    super.initState();
    stepTracker = StepTracker();
    FetchUsername();
    _initializePedometer();//method to make real time step counting
  }
  Future<void> FetchUsername() async {//metod 3lshan ageb esm el logged in user mn uid
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        setState(() {
          userName = userData.data()?['firstName'] ?? 'User';
        });
      }
    }
  }
  Future<void> _initializePedometer() async {//
    if (await _requestPermissions()) {// lw user accepts permision eturns true
      await stepTracker.initSteps();
      Pedometer.stepCountStream.listen(_onStepCount).onError(_onStepCountError);//
    } else {
      print('Activity recognition permission denied');
    }
  }
  Future<bool> _requestPermissions() async {
    return await Permission.activityRecognition.request().isGranted;
  }
  void _onStepCount(StepCount event) {// to update the steps count
    setState(() {
      stepTracker.updateSteps(event.steps);
      if (_currentMode == 'steps') {// user chooses step page from menu
        percentage = (stepTracker.todaySteps / stepGoal).clamp(0.0, 1.0);
      }
    });
  }
  void _onStepCountError(error) {
    print('Pedometer Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141313),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushReplacementNamed(context, 'profilescreen');
              Navigator.pushNamed(context, 'profilescreen');
            },
            icon: Icon(Icons.person, color: Colors.white, size: 35),
          ),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      drawer: Drawertap(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Welcome, $userName",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    progressColor: progressColor,
                    radius: 100,
                    lineWidth: 20,
                    backgroundColor: Colors.white,
                    percent: percentage,
                    center: _currentMode == 'steps'
                        ? Text(
                      '${stepTracker.todaySteps} steps',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                        : _currentMode == 'water'
                        ? Text(
                      '${(percentage * 100).toStringAsFixed(1)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                        : Text(
                      '${(percentage * 100).toStringAsFixed(1)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: 280,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                progressColor = Colors.red;
                                showFAB = false;
                                percentage = 1.0;
                                _currentMode = 'heart';
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                progressColor = Colors.green;
                                showFAB = false;
                                // Set progress based on steps taken
                                percentage = (stepTracker.todaySteps / stepGoal).clamp(0.0, 1.0);
                                _currentMode = 'steps';
                              });
                            },
                            icon: Icon(
                              Icons.snowshoeing_sharp,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                progressColor = Colors.blue;
                                showFAB = true;
                                // Set progress based on water consumed
                                percentage = (waterCounter / waterTarget).clamp(0.0, 1.0);
                                _currentMode = 'water';
                              });
                            },
                            icon: Icon(
                              Icons.water_drop_rounded,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showFAB)
                      CustomFAB(
                        incOnPressed: () {
                          setState(() {
                            waterCounter++;
                            percentage = (waterCounter / waterTarget).clamp(0.0, 1.0);
                          });
                        },
                        decOnPressed: () {
                          setState(() {
                            // Decrement water counter if positive and update progress
                            if (waterCounter > 0) waterCounter--;
                            percentage = (waterCounter / waterTarget).clamp(0.0, 1.0);
                          });
                        },
                        waterCounter: waterCounter,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

