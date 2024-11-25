import 'package:flutter/material.dart';

class PersonalBlogScreen extends StatelessWidget {
  const PersonalBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Personal Blogs !",),
            Text("COMING SOON!",),
          ],),
      ),
    );
  }
}
