
import 'package:flutter/foundation.dart';

class Post {
  final String book_id;  // Ganti dari int ke String
  final String book;
  final int chapter;

  Post({
    required this.book_id,
    required this.book,
    required this.chapter,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      book_id: json['book_id'] ?? "Unknown",  // Tangani null
      book: json['book'] ?? "Unknown",        // Tangani null
      chapter: json['chapter'] ?? 0,          // Tangani null
    );
  }
}
