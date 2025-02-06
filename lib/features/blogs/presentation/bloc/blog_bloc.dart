import 'dart:io';
import 'package:blog_app_revision/core/usecase/use_case.dart';
import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';
import 'package:blog_app_revision/features/blogs/domain/usecases/get_blogs.dart';
import 'package:blog_app_revision/features/blogs/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetBlogs getBlogs})
      :_getBlogs=getBlogs, _uploadBlog=uploadBlog, super(BlogInitial()) {
    on<BlogEvent>(
      (event, emit) => emit(
        BlogLoading(),
      ),
    );
    on<UploadBlogEvent>(_onUploadBlog);
    on<GetBlogsEvent>(_onFetchBlogs);
  }
  void _onFetchBlogs(GetBlogsEvent event, Emitter<BlogState> emit) async {
    final response = await _getBlogs(NoParams());
    response.fold(
      (failure) => emit(
        BlogFailure(
          errorMessage: failure.errMessage,
        ),
      ),
      (blogs) => emit(
        BlogsDisplaySuccess(blogs: blogs),
      ),
    );
  }

  void _onUploadBlog(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final response = await _uploadBlog(UploadBlogParams(
      title: event.title,
      content: event.content,
      image: event.image,
      posterId: event.posterId,
      topics: event.topics,
    ));
    response.fold(
        (failure) => emit(
              BlogFailure(
                errorMessage: failure.errMessage,
              ),
            ),
        (blog) => emit(
              BlogUploadSuccess(blog: blog),
            ));
  }
}
