import 'package:flutter/cupertino.dart';

class SignupViewModel{
  void navigation(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

}