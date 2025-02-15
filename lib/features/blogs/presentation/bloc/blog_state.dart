part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String errorMessage;
  BlogFailure({required this.errorMessage});
}

final class BlogUploadSuccess extends BlogState {
  final Blog blog;
  BlogUploadSuccess({required this.blog});
}
final class BlogsDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogsDisplaySuccess({required this.blogs});
}

