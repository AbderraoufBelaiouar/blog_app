import 'dart:io';
import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_revision/features/blogs/data/models/blog_model.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImplementation(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: Uuid().v1(),
          title: title,
          content: content,
          posterId: posterId,
          topics: topics,
          imageUrl: '',
          updatedAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        blog: blogModel,
        image: image,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getBlogs();
      return right(blogs);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
