import 'package:flutter/material.dart';
import 'package:get_started/screens/confirm_screen.dart';
import 'package:get_started/Authtextfield.dart';
import 'package:get_started/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers to get the text from the email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // A nullable string to hold any error messages from Firebase
  String? _errorMessage;

  // This function handles the sign-up process when the button is pressed.
  Future<void> _signUp() async {
    // Clear any previous error messages before attempting a new sign-up
    setState(() {
      _errorMessage = null;
    });

    try {
      // Create a new user with email and password using Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If the user creation is successful, navigate to the ConfirmScreen.
      // The 'mounted' check ensures we don't try to navigate if the widget is no longer in the tree.
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ConfirmScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors and update the error message.
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.message ?? 'An unknown Firebase error occurred.';
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      // Catch any other unexpected errors and update the error message.
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
      });
    }
  }

  // Dispose the controllers when the widget is removed from the widget tree
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D6B6B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D6B6B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up to get started!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 54, 169, 182),
                ),
              ),
              const SizedBox(height: 40),
              const AuthTextField(
                labelText: 'Full Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              const AuthTextField(
                labelText: 'Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              AuthTextField( // Updated to use the controller
                labelText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              const AuthTextField(
                labelText: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              AuthTextField( // Updated to use the controller
                labelText: 'Password',
                icon: Icons.lock,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              const AuthTextField(
                labelText: 'Confirm Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 40),
              // Display error message if it exists
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signUp, // Call the _signUp function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 56, 180, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Or sign up with',
                style: TextStyle(color: Color(0xFF5D6B6B)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google sign in logic
                    },
                    icon: Image.asset('assets/images/google_logo.png', height: 24),
                    label: const Text('Google', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Facebook sign in logic
                    },
                    icon: Image.asset('assets/images/facebook_logo.png', height: 24),
                    label: const Text('Facebook', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Color(0xFF5D6B6B)),
                    children: [
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          color: Color.fromARGB(255, 56, 180, 194),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
