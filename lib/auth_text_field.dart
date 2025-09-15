import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const AuthTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    // Initialize _passwordVisible with the isPassword property.
    // This makes sure the password field is obscured by default.
    _passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _passwordVisible,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Color(0xFF5D6B6B)),
        prefixIcon: Icon(widget.icon, color: const Color.fromARGB(255, 54, 169, 182)),
        // Conditionally add the suffix icon only for password fields
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: const Color.fromARGB(255, 54, 169, 182),
                ),
                onPressed: () {
                  // Toggle the state of password visibility
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
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