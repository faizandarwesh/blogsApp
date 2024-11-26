import 'package:blogs_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileController {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getUserProfile() async {
    final response = await supabase
        .from('author')
        .select('name, profile_image, email, phone_number, description ')
        .eq('id', userId!)
        .select();

    print("Get User Profile : $response");
    return response;

  }

  setUserProfile(String name, String phoneNumber, String description,
      String imageUrl) async {
    final response = await supabase.from('author').update({
      "name": name,
      "phoneNumber": phoneNumber,
      "description": description,
      "profile_image": imageUrl,
    }).select();

    print("Update User Profile : $response");
  }
}
