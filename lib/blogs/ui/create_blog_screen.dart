import 'package:blogs_app/blogs/controller/blog_controller.dart';
import 'package:blogs_app/utils/custom_button.dart';
import 'package:blogs_app/utils/helperfunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateBlogScreen extends StatefulWidget {
  final String title;
  final String content;
  final String coverImageUrl;

  const CreateBlogScreen({
    super.key,
    this.title = "",
    this.content = "",
    this.coverImageUrl = "",
  });

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final supabase = Supabase.instance.client;
  String coverImage = "";
  int minLength = 500;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    if (widget.title.isNotEmpty && widget.content.isNotEmpty) {
      _titleController.text = widget.title;
      _contentController.text = widget.content;
      coverImage = widget.coverImageUrl;
    }
    super.initState();
  }

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
                int? authorId = await HelperFunctions().getUserId();
                coverImage = await BlogController()
                    .uploadBlogCoverImage(context, authorId!, coverImage);
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
                    if (widget.coverImageUrl.isNotEmpty) ...[
                      CachedNetworkImage(
                        imageUrl: widget.coverImageUrl,
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          height: 200,
                          // Specify a fixed height or aspect ratio
                          color: Colors.grey[300],
                          // Placeholder color
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
                      const SizedBox(height: 16,)
                    ],
                    TextFormField(
                      controller: _titleController,
                      style: Theme.of(context).textTheme.headlineMedium!,
                      maxLines: 3,
                      minLines: 1,
                      maxLength: 50,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
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
                        BlogController().createBlog(
                            context, authorId!, title, content, coverImage);
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
