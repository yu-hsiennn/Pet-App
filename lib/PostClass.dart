import 'UserData.dart';
import 'package:flutter/material.dart';

class Post {
  final UserData poster;
  final String post_info;
  final List<String> pictures;
  final int like_count;
  final List<Comment> comments;
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


// fake data
List<Post> _posts = [
  Post(
    poster: _users[0],
    post_info: "Hi! First Post!!",
    pictures: [
      "assets/image/dog1.jpg",
      "assets/image/dog6.jpg",
      "assets/image/dog3.jpg"
    ],
    like_count: 251234,
    comments: [
      _comment[1],
      _comment[2],
      _comment[3],
      _comment[4]
    ]
  ),
  Post(
    poster: _users[2],
    post_info: "Hi! Nice to meet all!!",
    pictures: [
      "assets/image/dog4.jpg"
    ],
    like_count: 34,
    comments: [
      _comment[1],
      _comment[0],
    ]
  ),
  Post(
    poster: _users[4],
    post_info: "So hot!!",
    pictures: [
      "assets/image/dog5.jpg"
    ],
    like_count: 251,
    comments: [
      _comment[5],
      _comment[6]
    ]
  ),
];

List<UserData> _users = [
  UserData(
      name: "Bob",
      username: "bob",
      password: "123",
      photo: "assets/image/empty.jpg"
  ),
  UserData(
      name: "Alice",
      username: "alice",
      password: "123",
      photo: "assets/image/peach.jpg"
  ),
  UserData(
      name: "Joe",
      username: "joe",
      password: "123",
      photo: "assets/image/dog9.jpg"
  ),
  UserData(
      name: "Oreo",
      username: "oreo",
      password: "123",
      photo: "assets/image/dog8.jpg"
  ),
  UserData(
      name: "Bear",
      username: "bear",
      password: "123",
      photo: "assets/image/dog7.jpg"
  ),
];

List<Comment> _comment = [
  Comment(
      user: _users[0], 
      comment_info: "how are you", 
      like_count: 19
  ),
  Comment(
      user: _users[1], 
      comment_info: "how are you", 
      like_count: 17
  ),
  Comment(
      user: _users[2], 
      comment_info: "how are you", 
      like_count: 10
  ),
  Comment(
      user: _users[3], 
      comment_info: "how are you", 
      like_count: 11
  ),
  Comment(
      user: _users[4], 
      comment_info: "Cool!", 
      like_count: 14
  ),
  Comment(
      user: _users[2], 
      comment_info: "OMG! So Cute!!!", 
      like_count: 1285
  ),
  Comment(
      user: _users[3], 
      comment_info: "I totally agree with you!!", 
      like_count: 12
  ),
];
