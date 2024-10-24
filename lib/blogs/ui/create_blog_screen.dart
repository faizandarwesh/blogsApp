import 'package:blogs_app/blogs/controller/create_blog_controller.dart';
import 'package:blogs_app/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
