import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../model/blog.dart';

class BlogCardWidget extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;

  const BlogCardWidget({
    super.key,
    required this.blog,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none, // Allows the button to overflow out of the container
          children: [
            // Blog content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: blog.coverImage!.isEmpty
                        ? "https://images.unsplash.com/photo-1456324504439-367cee3b3c32?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                        : blog.coverImage!,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: 150, // Specify a fixed height or aspect ratio
                      color: Colors.grey[300], // Placeholder color
                      child: const Center(
                        child: CircularProgressIndicator
                            .adaptive(), // Loading indicator
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150, // Or any height you need
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        blog.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bookmark button, only visible if userId is different from blog.userId
            if (userId != blog.author.id)
              Positioned(
                top: 10, // Position the button slightly over the image
                right: 10, // Align it to the right
                child: GestureDetector(
                  onTap: () {
                    // Handle bookmark logic here
                    print("Bookmark clicked for blog: ${blog.id}");
                  },
                  child: Container(
                    width: 40, // Set the size of the button
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bookmark_add,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
