import 'package:blog_app_revision/features/blogs/presentation/views/add_blog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        actions: [
          IconButton(
              icon: Icon(CupertinoIcons.add_circled),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBlogView(),
                  ),
                );
              })
        ],
      ),
      body: Center(
        child: Text('Blogs View'),
      ),
    );
  }
}
