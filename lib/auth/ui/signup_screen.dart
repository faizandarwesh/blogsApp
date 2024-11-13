import 'package:blogs_app/auth/controller/auth_controller.dart';
import 'package:blogs_app/home/ui/blogs_listing_screen.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'custom_sign_in_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              "Blogs",
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16,),
            Text(
              "Express, explore, and engage with your blogs.",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            // Lottie animation in the center
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/raw/blog-animation.json', // Path to your Lottie file
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey, // Customize the divider color
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Or Sign In With",
                    style: TextStyle(
                      color: Colors.grey, // Customize text color
                      fontSize: 14, // Customize text size
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey, // Customize the divider color
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Sign up buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSignInButton(
                  image: "assets/icons/google.svg",
                  onPressed: () {
                    handleGoogleSignIn(context);
                  },
                ),
                CustomSignInButton(
                  image: "assets/icons/apple.svg",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BlogsListingScreen()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 40), // Extra space at the bottom
          ],
        ),
      ),
    );
  }
}

void handleGoogleSignIn(BuildContext context) async {
  User? user = await HelperFunctions().signInWithGoogle();
  if (user != null) {
    print("User signed in: ${user.displayName}");

    AuthController().createAuthor(user,context);

    // Navigate to your home screen or perform other actions
  } else {
    print("Google Sign-In failed");
  }
}
