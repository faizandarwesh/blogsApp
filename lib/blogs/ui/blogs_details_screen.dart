import 'package:blogs_app/blogs/controller/blog_controller.dart';
import 'package:blogs_app/blogs/ui/create_blog_screen.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../home/ui/blogs_listing_screen.dart';
import '../model/blog.dart';

class BlogsDetailsScreen extends StatelessWidget {
  final Blog blog;
  final int currentUserId;

  const BlogsDetailsScreen(
      {super.key, required this.blog, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Blogs',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (blog.author.id == currentUserId) ...[
            IconButton(
                onPressed: () {
                  HelperFunctions().showCustomBottomSheet(context, () {
                    // Close the blog screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateBlogScreen(
                                title: blog.title,
                                content: blog.content,
                                coverImageUrl: blog.coverImage ?? "",
                              )),
                    );
                  }, () {
                    HelperFunctions().dialogFunction(context, "Delete",
                        "Are you sure you want to delete this blog?", () {
                      BlogController().deleteBlog(context, blog.id);
                    });
                  });
                },
                icon: const Icon(Icons.more_vert))
          ]
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: blog.coverImage!.isEmpty
                  ? "https://images.unsplash.com/photo-1472289065668-ce650ac443d2?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                  : blog.coverImage!,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 200, // Specify a fixed height or aspect ratio
                color: Colors.grey[300], // Placeholder color
                child: const Center(
                  child:
                      CircularProgressIndicator.adaptive(), // Loading indicator
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              // Error icon
              fit: BoxFit.cover,
              // Adjust based on your needs
              width: double.infinity,
              // Take full width of the container
              height: 200, // Or any height you need
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              blog.title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Crafted by : ${blog.author.name}',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                blog.content,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
    );
  }
}
