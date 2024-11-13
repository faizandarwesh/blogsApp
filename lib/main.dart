import 'package:blogs_app/auth/ui/signup_screen.dart';
import 'package:blogs_app/home/ui/blogs_listing_screen.dart';
import 'package:blogs_app/utils/app_constants.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:blogs_app/utils/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: AppConstants.supabaseProjectUrl,
      anonKey: AppConstants.anonKey,
      headers: {"Authorization": AppConstants.serviceKey});

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeConfig().darkTheme,
      home: FutureBuilder(
          future: HelperFunctions().getLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If logged in, show Home screen; otherwise, show Login screen
              return snapshot.data == true
                  ? const BlogsListingScreen()
                  : const SignUpScreen();
            }
            // While waiting for the future to complete, show a loading spinner
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
    );
  }
}
