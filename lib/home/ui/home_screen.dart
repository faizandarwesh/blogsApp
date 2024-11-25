import 'package:blogs_app/home/ui/blogs_listing_screen.dart';
import 'package:blogs_app/personal_blogs/ui/personal_blog_screen.dart';
import 'package:blogs_app/profile/ui/user_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../bookmark/ui/bookmark_listing_screen.dart';
import '../../utils/helperfunctions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BlogsListingScreen(),
    const BookmarksListingScreen(),
    const PersonalBlogScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                HelperFunctions().dialogFunction(
                    context, 'Logout', 'Are you sure you want to logout?', () {
                  HelperFunctions().signOut(context);
                });
              },
              icon: const Icon(Icons.power_settings_new))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Blogs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(color: Color(0xFF6750A4)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: Theme.of(context).iconTheme.color),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder, color: Theme.of(context).iconTheme.color),
            label: 'My Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
