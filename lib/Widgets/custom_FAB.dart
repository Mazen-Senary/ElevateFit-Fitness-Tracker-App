import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key, required this.incOnPressed, required this.decOnPressed, required this.waterCounter});
  final int waterCounter;
  final VoidCallback incOnPressed;
  final VoidCallback decOnPressed;

  @override
  Widget build(BuildContext context) {
    int watercounter;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            mini: true,
            backgroundColor: Colors.red,
            onPressed: decOnPressed,
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 20),
          Text(
            '$waterCounter cups',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "btn2",
            mini: true,
            backgroundColor: Colors.blue,
            onPressed: incOnPressed,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
