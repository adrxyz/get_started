import 'package:flutter/material.dart';
import 'package:get_started/screens/confirm_screen.dart';
import 'package:get_started/auth_text_field.dart';
import 'package:get_started/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Controllers for all text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Nullable strings to hold various error messages
  String? _firebaseErrorMessage;
  String? _passwordMatchErrorMessage;
  String? _passwordLengthErrorMessage; // New state variable for password length
  String? _emailErrorMessage;
  String? _phoneNumberErrorMessage;
  String? _fieldErrorMessage;

  // This function handles the sign-up process when the button is pressed.
  Future<void> _signUp() async {
    // Clear any previous error messages before attempting a new sign-up
    setState(() {
      _firebaseErrorMessage = null;
      _passwordMatchErrorMessage = null;
      _passwordLengthErrorMessage = null; // Clear new error message
      _emailErrorMessage = null;
      _phoneNumberErrorMessage = null;
      _fieldErrorMessage = null;
    });

    // --- New Validation Logic ---
    // Check if any of the required fields are empty
    if (_fullNameController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      setState(() {
        _fieldErrorMessage = 'Please insert information.';
      });
      return; // Stop the sign-up process
    }

    // Check if password has a minimum length
    if (_passwordController.text.trim().length < 6) {
      setState(() {
        _passwordLengthErrorMessage = 'Password must be 6 or more characters.';
      });
      return; // Stop the sign-up process
    }

    // Check if passwords match
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      setState(() {
        _passwordMatchErrorMessage = 'Passwords do not match.';
      });
      return; // Stop the sign-up process
    }

    // Email format validation (using a regex for a more robust check)
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      setState(() {
        _emailErrorMessage = 'Invalid email.';
      });
      return; // Stop the sign-up process
    }

    // Phone number validation (must only contain digits)
    final phoneNumber = _phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      setState(() {
        _phoneNumberErrorMessage = 'Invalid.';
      });
      return; // Stop the sign-up process
    }

    // --- Firebase Authentication ---
    try {
      // Create a new user with email and password using Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If the user creation is successful, navigate to the ConfirmScreen.
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
        _firebaseErrorMessage = message;
      });
    } catch (e) {
      // Catch any other unexpected errors and update the error message.
      setState(() {
        _firebaseErrorMessage = 'An unexpected error occurred: $e';
      });
    }
  }

  // Dispose all controllers when the widget is removed from the widget tree
  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              // Display general empty field error message
              if (_fieldErrorMessage != null) ...[
                Text(
                  _fieldErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
              AuthTextField(
                labelText: 'Full Name',
                icon: Icons.person_outline,
                controller: _fullNameController,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                labelText: 'Username',
                icon: Icons.person,
                controller: _usernameController,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                labelText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              // Display email error message
              if (_emailErrorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  _emailErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              AuthTextField(
                labelText: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
              ),
              // Display phone number error message
              if (_phoneNumberErrorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  _phoneNumberErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              AuthTextField(
                labelText: 'Password',
                icon: Icons.lock,
                isPassword: true,
                controller: _passwordController,
              ),
              // Display password length error message
              if (_passwordLengthErrorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  _passwordLengthErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              AuthTextField(
                labelText: 'Confirm Password',
                icon: Icons.lock,
                isPassword: true,
                controller: _confirmPasswordController,
              ),
              // Display password match error message
              if (_passwordMatchErrorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  _passwordMatchErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              // Display Firebase error message if it exists
              if (_firebaseErrorMessage != null) ...[
                Text(
                  _firebaseErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
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
                  child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 18)),
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
