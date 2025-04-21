import 'package:elevate_fit/ViewModel/loginViewModel.dart';
import 'package:elevate_fit/Widgets/custom_ElevatedButton.dart';
import 'package:elevate_fit/Widgets/custom_TextField.dart';
import 'package:elevate_fit/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final emailcontroller = TextEditingController();
  final passwordcontroller= TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =LoginViewModel();

    // var size = MediaQuery.of(context).size;
    return
      SafeArea(
        child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 900,
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("images/logo.png",height: 350,),
                  Text("LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white
                    ),
              ),
                  SizedBox(height: 20,),
                  CustomTextfield( ispassword: false, hint: 'example@yourmail.domain',label: "Email: ",icon: Icon(Icons.mail),iconColor: Colors.white,controller: emailcontroller,validator: loginViewModel.validateEmail,),
                  SizedBox(height: 20,),
                  CustomTextfield( ispassword: true, hint: 'Enter your Password',label: "Password: ",icon: Icon(Icons.password_outlined),iconColor: Colors.white,controller: passwordcontroller,validator: loginViewModel.validatePassword,suffixIcon: Icon(Icons.visibility_off),),
                  SizedBox(height: 20,),
                  CustomElevatedbutton(
                    onPressed:  () {
                      if(_formKey.currentState!.validate())
                    loginViewModel.checkFields(emailcontroller, passwordcontroller, context);
                      loginViewModel.navigation(context, 'home');
                    },
                    text: "Login",
                    color: Color(0xff008080),
                  ),
                  SizedBox(height: 20,),
                  Text("Don't have an account?",style: TextStyle(color: Colors.white,fontSize: 16),),
                  TextButton(
                    onPressed: () {
                      loginViewModel.navigation(context, 'signup');
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
                    child: Text( 'Signup'),
                  )
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}
