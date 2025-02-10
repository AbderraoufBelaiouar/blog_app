
import 'package:blog_app_revision/features/blogs/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImplementation implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImplementation(this.box);
  @override
  void uploadBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (var i = 0; i < blogs.length; i++) {
      
      box.put(i.toString(), blogs[i].toMap());
    }
  }

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (var i = 0; i < box.length; i++) {
      final rawBlogData = box.get(i.toString());
      if (rawBlogData != null) {
        final Map<String, dynamic> blogData =
            Map<String, dynamic>.from(rawBlogData);
        blogs.add(BlogModel.fromMap(blogData));
      }
    }
    return blogs;
  }
}
