import 'package:bizlink/providers/auth.provider.dart';
import 'package:bizlink/utils/global.colors.dart';
import 'package:bizlink/view/home.view.dart';
import 'package:bizlink/view/login.view.dart';
import 'package:bizlink/view/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _isPasswordVisible = false; // Controls password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void register(BuildContext context) async{
    // auth service
    final auth = AuthService();

    if(_passwordController.text == _confirmPasswordController.text){
      try {
        await auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
        // After successful signup, navigate to the home page with fade-in transition
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Define the fade-in animation
              var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);

              // Apply FadeTransition to the child widget
              return FadeTransition(opacity: fadeAnimation, child: child);
            },
          ),
        );
      } catch (e) {
        showDialog(context: context, builder: ((context) => AlertDialog(
          title: Text(e.toString()),
        )),
        );
      }
    } else {
      showDialog(context: context, builder: ((context) => const AlertDialog(
        title: Text("Password don't match"),
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
                                'Sign Up',
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
                                'Create an account',
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
                      const SizedBox(height: 20), // Space between image and text fields

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
                      const SizedBox(height: 25), // Space between email and password fields

                      // Password Row
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                        ),
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
                      const SizedBox(height: 25), // Space between password and confirm password fields

                      // Confirm Password Row
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Use TextFormGlobal for confirm password field
                      TextFormGlobal(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: '•••••••••••••••',
                        isPasswordField: true,
                        isPasswordVisible: _isPasswordVisible,
                        togglePasswordVisibility: _togglePasswordVisibility,
                      ),
                      const SizedBox(height: 35), // Space between confirm password and sign up button

                      // Sign Up Button with full width
                      SizedBox(
                        width: double.infinity, // Make the button take full width
                        child: ElevatedButton(
                          onPressed: () => register(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: GlobalColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: GlobalColors.neutralColor,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Space between sign up button and Google sign-in option

                      // Or sign in with section
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '--------- or sign up with ---------',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Space between or sign up and Google button

                      // Google Sign-Up Button with Image Icon
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Google sign-up logic here
                            print("Google sign-up button pressed");
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
                                'Sign up with Google',
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

                      // Already have an account Text
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the Login screen
                            Navigator.push(
                                context, PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const LoginView(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child){
                                  // custom slide transition
                                  const begin = Offset(-1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;


                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                            ),
                            );
                          },
                          child: const Text(
                            'Already have an account? Login',
                            style: TextStyle(
                              fontSize: 16,
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
