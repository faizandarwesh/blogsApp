import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../blogs/model/blog.dart';
import '../../blogs/ui/blog_card_widget.dart';
import '../../blogs/ui/blogs_details_screen.dart';
import '../../home/controller/blogs_listing_controller.dart';
import '../../main.dart';

class PersonalBlogScreen extends StatefulWidget {
  const PersonalBlogScreen({super.key});

  @override
  State<PersonalBlogScreen> createState() => _PersonalBlogScreenState();
}

class _PersonalBlogScreenState extends State<PersonalBlogScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<dynamic>>(
            future: BlogsListingController().fetchBlogs(userId: userId),
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
                                            blog: blog)));
                          });
                    }),
              );
            }));
  }
}
