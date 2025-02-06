import 'package:blog_app_revision/features/blogs/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel(
      {required super.title,
      super.posterName,
      required super.id,
      required super.content,
      required super.imageUrl,
      required super.updatedAt,
      required super.posterId,
      required super.topics});

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      posterId: map['poster_id'] as String,
      topics: List<String>.from(map['topics'] ?? [] as List<String>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'updated_at': DateTime.now().toIso8601String(),
      'poster_id': posterId,
      'topics': topics,
    };
  }

  @override
  BlogModel copyWith(
      {String? id,
      String? title,
      String? content,
      String? imageUrl,
      DateTime? updatedAt,
      String? posterId,
      List<String>? topics,
      String? posterName}) {
    return BlogModel(
      posterName:posterName ?? this.posterName,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      posterId: posterId ?? this.posterId,
      topics: topics ?? this.topics,
    );
  }
}
/******  510a23c4-e6da-45ca-898a-29cb12b8a272  *******/
