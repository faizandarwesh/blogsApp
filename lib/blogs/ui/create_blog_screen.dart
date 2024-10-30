import 'package:blogs_app/blogs/controller/create_blog_controller.dart';
import 'package:blogs_app/utils/custom_button.dart';
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
          IconButton(onPressed: (){
            uploadImage("2");
          }, icon: const Icon(Icons.save))
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
                            .copyWith(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _contentController,
                      style: Theme.of(context).textTheme.headlineMedium!,
                      maxLines: 10,
                      minLines: 1,
                      maxLength: 500,
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
                            .copyWith(color: Colors.black),
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
                  onPressed: () {
                    if (_titleController.text.trim().isNotEmpty &&
                        _contentController.text.trim().isNotEmpty) {
                      final title = _titleController.text.trim();
                      final content = _contentController.text.trim();

                      CreateBlogController().createBlog(title, content);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> uploadImage(String blogId) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return;  // User canceled the picker

  final file = File(pickedFile.path);
  final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  try {
    // Upload file to the 'blog-images' bucket in Supabase Storage
    final response = await Supabase.instance.client.storage.from('images').upload(
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

    print('Image uploaded successfully: $publicUrl');
  } catch (e) {
    print('Failed to upload image: $e');
  }
}

