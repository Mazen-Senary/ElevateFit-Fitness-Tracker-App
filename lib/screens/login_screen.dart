import 'package:elevate_fit/Widgets/custom_ElevatedButton.dart';
import 'package:elevate_fit/Widgets/custom_TextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // var size = MediaQuery.of(context).size;
    return
      SafeArea(
        child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3C72), // Steel Blue - strong and cool
                Color(0xFF2A5298), // Teal-Blue mix - focused energy
                Color(0xFF121212), // Almost Black - adds intensity
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("images/logo.png"),
              Text("LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white
                ),
          ),
              SizedBox(height: 20,),
              CustomTextfield( ispassword: false, hint: 'example@yourmail.domain',label: "Email: ",icon: Icon(Icons.mail),iconColor: Colors.white,),
              SizedBox(height: 20,),
              CustomTextfield( ispassword: true, hint: 'Enter your Password',label: "Password: ",icon: Icon(Icons.password_outlined),iconColor: Colors.white,),
              SizedBox(height: 20,),
              CustomElevatedbutton(
                onPressed:  () {}, 
                text: "Login",
                color: Color(0xff008080), 
              ),

            ]
          ),
        )
      ),
    );
  }
}
