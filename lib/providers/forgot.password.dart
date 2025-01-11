import 'package:bizlink/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:bizlink/view/widgets/text.form.global.dart';
import 'package:bizlink/utils/global.colors.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPassword> {
  final auth = AuthService();
  final TextEditingController _emailController = TextEditingController();

  // Method to show Snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [GlobalColors.secondaryColor, GlobalColors.neutralColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Enter your email to reset password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email Field
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Email Input Field
                      TextFormGlobal(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'hello@example.com',
                        keyboardType: TextInputType.emailAddress,
                        togglePasswordVisibility: () {}, // Not needed here
                      ),
                      const SizedBox(height: 50),

                      // Reset Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              // Sending the reset password link
                              await auth.sendPasswordResetLink(_emailController.text);

                              // Show success message
                              showSnackBar("An email for password reset has been sent. Please check your inbox.");

                              // Navigate back to the login page
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pop(context);
                              });
                            } catch (e) {
                              // Show error message if the operation fails
                              showSnackBar("Failed to send reset email: $e");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: GlobalColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: GlobalColors.neutralColor,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Back to Login link
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Navigate back to the login page
                        },
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
