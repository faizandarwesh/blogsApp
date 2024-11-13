import 'package:blogs_app/blogs/ui/blogs_details_screen.dart';
import 'package:blogs_app/home/controller/blogs_listing_controller.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/controller/auth_controller.dart';
import '../../blogs/model/blog.dart';
import '../../blogs/ui/create_blog_screen.dart';

class BlogsListingScreen extends StatefulWidget {
  const BlogsListingScreen({super.key});

  @override
  State<BlogsListingScreen> createState() => _BlogsListingScreenState();
}

class _BlogsListingScreenState extends State<BlogsListingScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
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
          backgroundColor: Theme.of(context).primaryColor,
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
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              // If there was an error, display a message
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching blogs'));
              }
              // If the list is empty, show a message
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No blogs found'));
              }

              // Convert the data to a list of Blog objects
              final blogs = snapshot.data!
                  .map((item) => Blog.fromJson(item as Map<String, dynamic>))
                  .toList();

              return RefreshIndicator(
                onRefresh: () => BlogsListingController().fetchBlogs(),
                child: ListView.separated(
                    itemCount: blogs.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 16,
                      );
                    },
                    itemBuilder: (context, index) {
                      final Blog blog = blogs[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogsDetailsScreen(blog: blog)));
                        },
                        child: ListTile(
                          title: Text(blog.title),
                          subtitle: Text(
                            blog.content,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      );
                    }),
              );
            }));
  }
}
