import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.label,
    this.ispassword = false,
    required this.icon,
    this.iconColor,
    this.type,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.onTapFunction,
  });

  final String hint;
  final String label;
  final Icon icon;
  final Icon? suffixIcon;
  final Color? iconColor;
  final bool ispassword;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: ispassword,
        keyboardType: type,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            gapPadding: 20,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff008080), width: 2),
          ),
          label: Text(
            label,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          suffixIcon: suffixIcon != null
              ? GestureDetector(
            onTap: onTapFunction,
            child: suffixIcon,
          )
              : null,

          prefixIcon: icon,
          prefixIconColor: iconColor,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
