import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  const CustomElevatedbutton({super.key, required this.onPressed, required this.text, this.color = Colors.blueAccent, });
  final VoidCallback onPressed;
  final String text;
  final Color?color;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 45,
      child: ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17))
        ),
        child: Text(text,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white),
        ),
      ),
    );
  }
}
