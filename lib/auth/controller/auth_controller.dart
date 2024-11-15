import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;
import 'package:flutter/material.dart';

import '../../home/ui/blogs_listing_screen.dart';

class AuthController {
  final supabase = Supabase.instance.client;

  Future<void> createAuthor(user.User googleUser, BuildContext context) async {
    final supabase = Supabase.instance.client;

    // Get the Google user info
    final userId = googleUser.uid;
    final email = googleUser.email;
    final userName = googleUser.displayName;
    final userProfileImage = googleUser.photoURL;

    try {
      // Insert or update the user record in the author table

      final existingUser = await supabase
          .from('author')
          .select()
          .eq('email', email as Object)
          .maybeSingle();

      if (existingUser != null) {

        //Add record in shared preferences to remember user is already logged in
        HelperFunctions().saveLoginStatus(true);
        HelperFunctions().setUserId(existingUser['id']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BlogsListingScreen()),
          (route) => false,
        );
      } else {
        final response = await supabase.from('author').upsert({
          'google_id': userId,
          'name': userName,
          'email': email,
          'profile_image': userProfileImage,
          'created_at': DateTime.now().toIso8601String(),
          // Optional, as created_at may be auto-handled
        }).select();

        print("Result : $response");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BlogsListingScreen()),
          (route) => false,
        );

        //Add record in shared preferences to remember user is already logged in
        HelperFunctions().saveLoginStatus(true);
        HelperFunctions().setUserId(response[0]['id']);
      }
    } catch (error) {
      print("Something went wrong : $error");
    }
  }
}
