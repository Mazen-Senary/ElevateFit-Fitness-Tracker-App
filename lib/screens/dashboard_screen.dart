
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_fit/Widgets/custom_FAB.dart';
import 'package:elevate_fit/Widgets/custom_drawer_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import '../Widgets/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double percentage = 1.0;
  int waterCounter = 0;
  int waterTarget = 8;
  bool showFAB = false;
  Color progressColor = Colors.red;
  String userName = "";
  @override
  void initState() {
    super.initState();
    FetchUsername();
  }

  Future<void> FetchUsername() async {
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
            onPressed: () {},
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
                    center: showFAB
                        ? Text(
                      '${(percentage * 100).toStringAsFixed(1)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                        : const SizedBox.shrink(),
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
                                percentage = 1.0;
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
                                percentage = (waterCounter / waterTarget).clamp(0.0, 1.0);
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
