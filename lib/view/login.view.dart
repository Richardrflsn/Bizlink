import 'package:bizlink/providers/auth.provider.dart';
import 'package:bizlink/providers/forgot.password.dart';
import 'package:bizlink/utils/global.colors.dart';
import 'package:bizlink/view/home.view.dart';
import 'package:bizlink/view/signup.view.dart';
import 'package:bizlink/view/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordVisible = false; // Controls password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void login(BuildContext context) async {
    // authService
    final authService = AuthService();

    // Try Login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
      // After successful login, navigate to the home page with fade-in transition
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Define the fade-in animation
            var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);

            // Apply FadeTransition to the child widget
            return FadeTransition(opacity: fadeAnimation, child: child);
          },
        ),
      );
    } catch(e) {
      showDialog(context: context, builder: ((context) => AlertDialog(
        title: Text(e.toString()),
      )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, // Set the status bar to dark style
        child: Container(
          width: double.infinity, // Ensure full width
          height: double.infinity, // Ensure full height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [GlobalColors.secondaryColor, GlobalColors.neutralColor], // Gradient colors
              begin: Alignment.topCenter, // Gradient start point
              end: Alignment.bottomCenter, // Gradient end point
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0), // Adjusted padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spaces out text and image
                        crossAxisAlignment: CrossAxisAlignment.center, // Align text and image vertically centered
                        children: [
                          // Left Column to stack two texts
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the left
                            mainAxisAlignment: MainAxisAlignment.center, // Align texts vertically in the column
                            children: [
                              // First Text
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black, // Text color
                                  fontSize: 32,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.bold, // Bold text
                                ),
                              ),
                              SizedBox(height: 5), // Space between texts
                              // Second Text
                              Text(
                                'Welcome back',
                                style: TextStyle(
                                  color: Colors.black, // Lighter text color
                                  fontSize: 18,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          // Right Image
                          Image.asset(
                            'assets/images/iconBizlink.png', // Path to your image
                            width: 120, // Set the width of the image
                            height: 120, // Set the height of the image
                            fit: BoxFit.cover, // Ensures the image covers the given space
                          ),
                        ],
                      ),
                      const SizedBox(height: 40), // Space between image and text fields

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
                      // Use TextFormGlobal for email field
                      TextFormGlobal(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'hello@example.com',
                        keyboardType: TextInputType.emailAddress,
                        togglePasswordVisibility: _togglePasswordVisibility,
                      ),
                      const SizedBox(height: 30), // Space between email and password fields

                      // Password Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue, // Link color
                                fontSize: 16,
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Use TextFormGlobal for password field
                      TextFormGlobal(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: '•••••••••••••••',
                        isPasswordField: true,
                        isPasswordVisible: _isPasswordVisible,
                        togglePasswordVisibility: _togglePasswordVisibility,
                      ),
                      const SizedBox(height: 50), // Space between password and login button

                      // Login Button with full width
                      SizedBox(
                        width: double.infinity, // Make the button take full width
                        child: ElevatedButton(
                          onPressed: () => login(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: GlobalColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              color: GlobalColors.neutralColor,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Space between login button and Google sign-in option

                      // Or sign in with section
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '--------- or sign in with ---------',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Space between or sign in and Google button

                      // Google Sign-In Button with Image Icon
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Google sign-in logic here
                            print("Google sign-in button pressed");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: GlobalColors.greyColor, // Google red color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/googleIcon.png', // Path to your Google icon image
                                height: 24, // Adjust the size of the icon
                              ),
                              const SizedBox(width: 10), // Space between the icon and text
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30), // Space before create account text

                      // Create an Account Text
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the Create Account screen or show a dialog
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => const SignupView()),
                            );
                          },
                          child: const Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w500,
                              color: Colors.blue, // Link color
                            ),
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
