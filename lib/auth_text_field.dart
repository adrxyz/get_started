import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  // This parameter is required to allow the parent widget to control the text field.
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF5D6B6B)),
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 54, 169, 182)),
        filled: true,
        fillColor: const Color(0xFFE1EAEA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color.fromARGB(255, 56, 180, 194), width: 2),
        ),
      ),
      style: const TextStyle(color: Color(0xFF5D6B6B)),
    );
  }
}
