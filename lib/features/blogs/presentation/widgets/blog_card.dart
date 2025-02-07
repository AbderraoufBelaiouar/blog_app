import 'package:blog_app_revision/core/theme/app_pallete.dart';
import 'package:blog_app_revision/core/utils/calculate_reading_time.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/presentation/views/blog_details_view.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.color});
  final Blog blog;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailsView(
              blog: blog,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Chip(
                              color: WidgetStatePropertyAll(
                                  AppPallete.backgroundColor),
                              label: Text(
                                e,
                              ),
                              side: BorderSide(color: AppPallete.bordercolor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text("${calculateReadingTime(blog.content)} min")
          ],
        ),
      ),
    );
  }
}
