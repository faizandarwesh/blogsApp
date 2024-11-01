import 'package:supabase_flutter/supabase_flutter.dart';

class BlogsListingController {
  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchBlogs() async {
    return await supabase.from('blogs').select('id, title, content, cover_image, created_at, author:author_id ( name )');
  }
}
