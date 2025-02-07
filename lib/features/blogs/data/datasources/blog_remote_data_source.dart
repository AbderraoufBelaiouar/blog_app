import 'dart:io';

import 'package:blog_app_revision/core/error/exception.dart';
import 'package:blog_app_revision/core/error/failure.dart';
import 'package:blog_app_revision/features/blogs/data/models/blog_model.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});
  Future<List<Blog>> getBlogs();
}

class BlogRemoteDataSourceImplementation implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImplementation({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await supabaseClient.from('blogs').insert(blog.toMap()).select();

      return BlogModel.fromMap(response[0]);
    } on ServerException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
       await supabaseClient.storage
          .from('blog_images')
          .upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Blog>> getBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*,profiles(name)');
      return blogs
          .map(
            (e) => BlogModel.fromMap(e).copyWith(
              posterName: e['profiles']['name'] as String,
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
