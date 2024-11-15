import 'package:blogs_app/blogs/ui/blogs_details_screen.dart';
import 'package:blogs_app/home/controller/blogs_listing_controller.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../blogs/model/blog.dart';
import '../../blogs/ui/blog_card_widget.dart';
import '../../blogs/ui/create_blog_screen.dart';

class BlogsListingScreen extends StatefulWidget {
  const BlogsListingScreen({super.key});

  @override
  State<BlogsListingScreen> createState() => _BlogsListingScreenState();
}

class _BlogsListingScreenState extends State<BlogsListingScreen> {
  final supabase = Supabase.instance.client;
  late int currentUserId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HelperFunctions().getUserId().then((value) {
        currentUserId = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateBlogScreen()));
            }),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  HelperFunctions().dialogFunction(
                      context, 'Logout', 'Are you sure you want to logout?',
                          () {
                        HelperFunctions().signOut(context);
                      });
                },
                icon: const Icon(Icons.power_settings_new))
          ],
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          title: const Text(
            'Blogs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
            future: BlogsListingController().fetchBlogs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              // If there was an error, display a message
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching blogs'));
              }
              // If the list is empty, show a message
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Image.asset(
                        "assets/images/empty_blogs_placeholder.png"));
              }

              // Convert the data to a list of Blog objects
              final blogs = snapshot.data!
                  .map((item) => Blog.fromJson(item as Map<String, dynamic>))
                  .toList();

              return RefreshIndicator(
                onRefresh: () => BlogsListingController().fetchBlogs(),
                child: ListView.builder(
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      final Blog blog = blogs[index];

                      return BlogCardWidget(
                          blog: blog,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BlogsDetailsScreen(
                                            currentUserId: currentUserId,
                                            blog: blog)));
                          });
                    }),
              );
            }));
  }
}