import 'package:flutter/material.dart';

class BlogsDetailsScreen extends StatelessWidget {
  final dynamic blog;

  const BlogsDetailsScreen({
    super.key,
    this.blog
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Blogs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Text(
                blog['title'],
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Crafted by : ${blog['author']['name']}',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16,),
              Text(
                blog['content'],
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}
