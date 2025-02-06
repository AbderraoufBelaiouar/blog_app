class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime updatedAt;
  final String posterId;
  final List<String> topics;
  final String? posterName;

  const Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      this.posterName, 
      required this.updatedAt,
      required this.posterId,
      required this.topics});

  Blog copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? updatedAt,
    String? posterId,
    List<String>? topics,
    String? posterName,
  }) {
    return Blog(
      posterName: posterName ?? this.posterName,
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
