class Blog {
  final int id;
  final String title;
  final String content;
  final String? coverImage;
  final DateTime createdAt;
  final Author author;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    this.coverImage,
    required this.createdAt,
    required this.author,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      coverImage: json['cover_image'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'cover_image': coverImage,
      'created_at': createdAt.toIso8601String(),
      'author': author.toJson(),
    };
  }
}

class Author {
  final String name;

  Author({required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
