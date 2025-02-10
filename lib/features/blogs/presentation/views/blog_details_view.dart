import 'package:blog_app_revision/core/utils/calculate_reading_time.dart';
import 'package:blog_app_revision/core/utils/formate_date.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/presentation/widgets/image_builder.dart';
import 'package:flutter/material.dart';

class BlogDetailsView extends StatelessWidget {
  const BlogDetailsView({super.key, required this.blog});
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'by ${blog.posterName!}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                ImageBuilder(blog: blog),
                SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
