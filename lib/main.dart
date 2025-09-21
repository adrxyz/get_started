import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_started/screens/onboarding_screen.dart';
import 'package:get_started/firebase_options.dart';
import 'package:flutter/services.dart';

// Assuming you have a menu_view.dart file
// import 'package:get_started/menu_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Asian Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F0E0),
        primaryColor: const Color(0xFF1A237E),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF0F0E0),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black54),
          headlineSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
        ),

        // This is the corrected Card Theme to remove the shadow
        cardTheme: CardThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0, // Set elevation to 0 to remove the shadow
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}