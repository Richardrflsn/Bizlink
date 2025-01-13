import 'package:bizlink/utils/global.colors.dart';
import 'package:bizlink/view/login.view.dart';
import 'package:bizlink/view/signup.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

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
                    mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
                    crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center the content
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Image.asset(
                          'assets/images/chefCooking.png',
                          width: 295,
                          height: 273,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Fresh from the kitchen\n to your desk',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity, // Make the button take full width
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle sign-up logic
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: GlobalColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Login with email',
                            style: TextStyle(
                              fontSize: 20,
                              color: GlobalColors.neutralColor,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

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
                                'Login with Google',
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
                      const SizedBox(height: 35),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Sign Up screen
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const SignupView()),
                              );
                            },
                            child: const Text(
                              'Sign up now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      const Text.rich(
                        TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: ' and acknowledge our ',
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
