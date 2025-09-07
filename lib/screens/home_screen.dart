import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F7),
      appBar: AppBar(
        title: const Text('Home Screen', style: TextStyle(color: Color(0xFF5D6B6B))),
        backgroundColor: const Color(0xFFF1F7F7),
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D6B6B),
          ),
        ),
      ),
    );
  }
}