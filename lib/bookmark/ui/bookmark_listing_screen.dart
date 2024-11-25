import 'package:flutter/material.dart';

class FavoritesListingScreen extends StatelessWidget {
  const FavoritesListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Favorites !",),
          Text("COMING SOON!",),
        ],),
      ),
    );
  }
}
