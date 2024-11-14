import 'package:blogs_app/blogs/controller/create_blog_controller.dart';
import 'package:blogs_app/utils/custom_button.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateBlogScreen extends StatefulWidget {
  final String title;
  final String content;

  const CreateBlogScreen({
    super.key,
    this.title = "",
    this.content = "",
  });

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final supabase = Supabase.instance.client;
  String coverImageUrl = "";
  int minLength = 500;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Write your First Blog!',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                coverImageUrl = await uploadImage("2", coverImageUrl);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      style: Theme.of(context).textTheme.headlineMedium!,
                      maxLines: 3,
                      minLines: 1,
                      maxLength: 50,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: 'Title',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _contentController,
                      style: Theme.of(context).textTheme.bodyLarge!,
                      maxLines: null,
                      minLines: 10,
                      maxLength: 25000,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: 'Content',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomButton(
                  label: 'Post',
                  onPressed: () async {
                    if (_titleController.text.trim().isNotEmpty &&
                        _contentController.text.trim().isNotEmpty) {
                      if (_contentController.text.length < minLength) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Content must be at least $minLength characters long')),
                        );
                      } else {
                        final title = _titleController.text.trim();
                        final content = _contentController.text.trim();

                        int? authorId = await HelperFunctions().getUserId();
                        CreateBlogController().createBlog(
                            context, authorId!, title, content, coverImageUrl);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill the required fields')),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<String> uploadImage(String blogId, String coverImageUrl) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return ""; // User canceled the picker

  final file = File(pickedFile.path);
  final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  try {
    // Upload file to the 'blog-images' bucket in Supabase Storage
    final response = await Supabase.instance.client.storage
        .from('images')
        .upload(
          'blogs/$blogId/$fileName',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    /*  if (response != null) {
      throw Exception(response!.message);
    }*/

    // Optional: Get the public URL (if bucket is public)
    final publicUrl = Supabase.instance.client.storage
        .from('images')
        .getPublicUrl('blogs/$blogId/$fileName');

    coverImageUrl = publicUrl;
    print('Image uploaded successfully: $publicUrl');
  } catch (e) {
    print('Failed to upload image: $e');
  }

  return coverImageUrl;
}
