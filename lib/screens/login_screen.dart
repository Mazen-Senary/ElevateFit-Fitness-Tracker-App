import 'package:elevate_fit/ViewModel/loginViewModel.dart';
import 'package:elevate_fit/Widgets/custom_elevated_button.dart';
import 'package:elevate_fit/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = LoginViewModel();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 900,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E3C72),
                  Color(0xFF2A5298),
                  Color(0xFF121212),
                ],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("images/logo.png", height: 350),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    ispassword: false,
                    hint: 'example@yourmail.domain',
                    label: "Email: ",
                    icon: Icon(Icons.mail),
                    iconColor: Colors.white,
                    controller: emailcontroller,
                    validator: loginViewModel.validateEmail,
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    ispassword: !isvisible,
                    hint: 'Enter your Password',
                    label: "Password: ",
                    icon: Icon(Icons.password_outlined),
                    iconColor: Colors.white,
                    controller: passwordcontroller,
                    validator: loginViewModel.validatePassword,
                    suffixIcon: Icon(
                      isvisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onTapFunction: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  CustomElevatedbutton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bool success = loginViewModel.checkFields(
                          emailcontroller,
                          passwordcontroller,
                          context,
                        );
                        if (success) {
                          loginViewModel.navigation(context, 'homescreen');
                        }
                      }
                    },
                    text: "Login",
                    color: Color(0xff008080),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      loginViewModel.navigation(context, 'signup');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Signup'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//