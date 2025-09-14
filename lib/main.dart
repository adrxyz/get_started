import 'package:flutter/material.dart';
import 'package:get_started/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// The main function is now asynchronous to allow for Firebase initialization.
void main() async {
  // Ensure that Flutter is initialized before calling Firebase functions.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the Firebase app using the default options for the current platform.
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
