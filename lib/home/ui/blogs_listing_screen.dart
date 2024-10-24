import 'package:blogs_app/home/controller/blogs_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
                return const Center(child: CircularProgressIndicator());
              }
              // If there was an error, display a message
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching blogs'));
              }
              // If the list is empty, show a message
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No blogs found'));
              }

              final blogs = snapshot.data!;

              return ListView.separated(
                  itemCount: blogs.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    final blog = blogs[index];

                    return ListTile(
                      title: Text('${blog['title']}'),
                      subtitle: Text('${blog['content']}'),
                    );
                  });
            }));
  }
}
