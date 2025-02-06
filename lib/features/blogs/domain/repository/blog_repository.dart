import 'dart:io';

import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required File image,
  });
  Future<Either<Failure, List<Blog>>> getBlogs();
}
