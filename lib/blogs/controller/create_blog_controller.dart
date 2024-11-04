import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateBlogController {
  final supabase = Supabase.instance.client;

  createBlog(BuildContext context,String title, String content,String imageUrl) async {

    //Show loading dialog
   HelperFunctions().showLoadingDialog(context);

    try {
      final data = await supabase.from('blogs').insert({'title': title, 'content': content,'cover_image': imageUrl}).select();

      // Close the loading dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$data')),
      );

      // Close the blog screen
      Navigator.of(context).pop();
    } catch (error) {
      // Close the loading dialog in case of error
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post blog: $error')),
      );
    }
  }
}
