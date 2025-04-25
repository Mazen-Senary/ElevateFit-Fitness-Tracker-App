import 'package:elevate_fit/Widgets/custom_FAB.dart';
import 'package:elevate_fit/Widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import '../Widgets/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
// feat a
class _DashboardScreenState extends State<DashboardScreen> {
  double percentage = 1.0;
  int waterCounter = 0;
  int waterTarget = 8;
  bool showFAB = false;
  Color progressColor = Colors.red;
  int myIndex = 0;
  Text? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
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
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      backgroundColor: Color(0xFF141313),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.white, size: 35),
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
                  "Welcome, User",
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
                    center:
                        showFAB
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
                          Center(
                            child: IconButton(
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
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                progressColor = Colors.blue;
                                showFAB = true;
                                percentage = (waterCounter / 8).clamp(0.0, 1.0);
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
                            percentage = (waterCounter / 8).clamp(0.0, 1.0);
                            Colors.blue;
                            Colors.blue.shade100;
                          });
                        },
                        decOnPressed: () {
                          setState(() {
                            if (waterCounter > 0) waterCounter--;
                            percentage = (waterCounter / 8).clamp(0.0, 1.0);
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
