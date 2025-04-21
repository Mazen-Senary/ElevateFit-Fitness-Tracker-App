import 'package:elevate_fit/ViewModel/SignupViewModel.dart';
import 'package:elevate_fit/Widgets/custom_ElevatedButton.dart';
import 'package:elevate_fit/Widgets/custom_TextField.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupViewModel signupViewModel = SignupViewModel();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 800,
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
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/signup_logo.png", width: 120, height: 120,),
                  ],
                ),
                SizedBox(height: 30,),
                Text("Sign Up",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white
                )),
                SizedBox(height: 20,),
                CustomTextfield(hint: "Enter your name", label: "Name", icon: Icon(Icons.abc),iconColor: Colors.white,),
                SizedBox(height: 20,),
                CustomTextfield(hint: "Email", label: "Email", icon: Icon(Icons.email),iconColor: Colors.white,),
                SizedBox(height: 20,),
                CustomTextfield(hint: "Enter your Phone Number", label: "Phone Number:", icon: Icon(Icons.phone),iconColor: Colors.white,type: TextInputType.number,),
                SizedBox(height: 20,),
                CustomTextfield(hint: "Password", label: "Password", icon: Icon(Icons.password_outlined),iconColor: Colors.white,ispassword: true,),
                SizedBox(height: 20,),
                CustomElevatedbutton(onPressed: (){}, text: "Sign up",color: Color(0xff008080),),
                SizedBox(height: 20,),
                Text("Already have an account?",style: TextStyle(color: Colors.white,fontSize: 16),),
                TextButton(
                  onPressed: () {
                    signupViewModel.navigation(context, 'login');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,         // Text color
                    backgroundColor: Colors.transparent,   // Button background
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text( 'Login'),
                )
              ],
            ),
          
          ),
        ),
      ),
    );
  }
}
