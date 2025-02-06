part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class UploadBlogEvent extends BlogEvent {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;
  UploadBlogEvent({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}

class GetBlogsEvent extends BlogEvent {}
