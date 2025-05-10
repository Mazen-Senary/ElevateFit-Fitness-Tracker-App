
import 'package:elevate_fit/ViewModel/SignupViewModel.dart';
import 'package:elevate_fit/Widgets/custom_elevated_button.dart';
import 'package:elevate_fit/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  Color(0xFF1E3C72),
                  Color(0xFF2A5298),
                  Color(0xFF121212),
                ],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/signup_logo.png",
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Enter your name",
                    label: "Name",
                    icon: Icon(Icons.abc),
                    iconColor: Colors.white,
                    controller: nameController,
                    validator: signupViewModel.validateName,
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Enter your Username",
                    label: "username",
                    icon: Icon(Icons.abc),
                    iconColor: Colors.white,
                    controller: usernameController,
                    validator: signupViewModel.validateName,
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Email",
                    label: "Email",
                    icon: Icon(Icons.email),
                    iconColor: Colors.white,
                    controller: emailController,
                    validator: signupViewModel.validateEmail,
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Enter your Phone Number",
                    label: "Phone Number",
                    icon: Icon(Icons.phone),
                    iconColor: Colors.white,
                    type: TextInputType.number,
                    controller: phoneController,
                    validator: signupViewModel.validateNumber,
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    hint: "Password",
                    label: "Password",
                    icon: Icon(Icons.password_outlined),
                    iconColor: Colors.white,
                    ispassword: true,
                    controller: passwordController,
                    validator: signupViewModel.validatePassword,
                  ),
                  SizedBox(height: 20),
                  CustomElevatedbutton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signupViewModel.signUp(context,emailController.text, passwordController.text, nameController.text,  phoneController.text,
                          usernameController.text,);
                      }
                      //   String email = emailController.text;
                      //   String password = passwordController.text;
                      //   String firstName = nameController.text;
                      //   signupViewModel.signUp(context, email, password,firstName);
                      // }
                    },
                    text: "Sign up",
                    color: Color(0xff008080),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      signupViewModel.navigation(context, 'login');
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
                    child: Text('Login'),
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
