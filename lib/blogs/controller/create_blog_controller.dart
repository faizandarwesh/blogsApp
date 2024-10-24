import 'package:supabase_flutter/supabase_flutter.dart';

class CreateBlogController {
  final supabase = Supabase.instance.client;

  createBlog(String title, String content) async {
    await supabase.from('blogs').insert({'title': title, 'content': content});
  }
}
