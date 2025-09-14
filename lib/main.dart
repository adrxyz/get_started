import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_started/screens/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that Flutter widgets are initialized before Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the default options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
