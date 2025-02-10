import 'dart:io';
import 'package:blog_app_revision/core/constants/constants.dart';
import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/network/connection_checker.dart';
import 'package:blog_app_revision/features/blogs/data/datasources/blog_local_data_source.dart';
import 'package:blog_app_revision/features/blogs/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app_revision/features/blogs/data/models/blog_model.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;
  const BlogRepositoryImplementation(this.blogRemoteDataSource,
      this.connectionChecker, this.blogLocalDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noInternetConnectionessage));
      }
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
      if (!await connectionChecker.isConnected) {
        
        return right(blogLocalDataSource.loadBlogs());
      }
      final blogs = await blogRemoteDataSource.getBlogs();
      blogLocalDataSource.uploadBlogs(blogs: blogs);
        
      return right(blogs);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
