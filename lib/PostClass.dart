import 'UserData.dart';
import 'package:flutter/material.dart';

class Post {
  final UserData poster;
  final String post_info;
  final List<String> pictures;
  final int like_count;
  final Comment comments;
  Post({
    required this.poster,
    required this.post_info,
    required this.pictures,
    required this.like_count,
    required this.comments,
  });
}

class Comment {
  final UserData user;
  final String comment_info;
  final int like_count;
  Comment({
    required this.user,
    required this.comment_info,
    required this.like_count,
  });
}