import 'dart:io';

import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../home/ui/blogs_listing_screen.dart';

class BlogController {
  final supabase = Supabase.instance.client;

  createBlog(BuildContext context, int authorId, String title, String content,
      String imageUrl) async {
    //Show loading dialog
    HelperFunctions().showLoadingDialog(context);

    try {
      final data = await supabase.from('blogs').insert({
        'title': title,
        'content': content,
        'cover_image': imageUrl,
        'author_id': authorId
      }).select();

      // Close the loading dialog
      Navigator.of(context).pop();

      if (data.isNotEmpty) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blog posted successfully')),
        );

        // Close the blog screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BlogsListingScreen()),
          (route) => false,
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
    } catch (error) {
      // Close the loading dialog in case of error
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post blog: $error')),
      );
    }
  }

  Future<String> uploadBlogCoverImage(
      BuildContext context, int userId, String coverImageUrl) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return ""; // User canceled the picker

    final file = File(pickedFile.path);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      //Show loading dialog
      HelperFunctions().showLoadingDialog(context);

      // Upload file to the 'blog-images' bucket in Supabase Storage
      final response = await Supabase.instance.client.storage
          .from('images')
          .upload(
            'blogs/$userId/$fileName',
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      // Optional: Get the public URL (if bucket is public)
      final publicUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl('blogs/$userId/$fileName');

      coverImageUrl = publicUrl;
      // Close the loading dialog
      Navigator.of(context).pop();
      print('Image uploaded successfully: $publicUrl');
    } catch (e) {
      print('Failed to upload image: $e');
    }

    return coverImageUrl;
  }

  deleteBlog(BuildContext context, int blogId) async{

    //Show loading dialog
    HelperFunctions().showLoadingDialog(context);

    final response = await supabase.from('blogs').delete().eq('id', blogId).select();

    if(response.isNotEmpty){

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog removed successfully')),
      );

      // Close the blog screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BlogsListingScreen()),
            (route) => false,
      );
    }
    else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
  }
}
