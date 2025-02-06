import 'dart:io';

import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  const UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
      image: params.image,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;
  const UploadBlogParams({
      required this.title,required this.content,required this.posterId,required this.topics,required this.image});
}
