import 'package:supabase_flutter/supabase_flutter.dart';

class BlogsListingController {
  final supabase = Supabase.instance.client;

  Future<List<dynamic>> fetchBlogs({int? userId}) async {
    var query = await supabase.from('blogs').select('id, title, content, cover_image, created_at, author:author_id ( name, id )');

    if(userId != null){
      query = await supabase.from('blogs').select('id, title, content, cover_image, created_at, author:author_id ( name, id )').eq('author_id', userId);
      // query.eq('author_id',userId);
    }

    return query;
  }
}
