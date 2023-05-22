
class UserData {
  String name;
  String username;
  String password;
  int follower;
  int posts_count;
  String intro;
  int pet_count;
  String photo;
  List<PetDetail> petdatas;

  UserData(
      {this.name = '',
      required this.username,
      required this.password,
      this.follower = 0,
      this.posts_count = 0,
      this.intro = '',
      this.pet_count = 0,
      this.photo = '',
      this.petdatas = const []});
}

class PetDetail {
  String name;
  String breed;
  String gender;
  int age;
  List<String> personality_lable;
  String photo;

  PetDetail({
    required this.name,
    required this.breed,
    required this.gender,
    required this.age,
    required this.personality_lable,
    required this.photo
  });
}

class Post {
  final UserData poster;
  final String post_info;
  final String pictures;
  final List<String> label;
  final int like_count;
  final List<Comment> comments;
  Post({
    required this.poster,
    required this.post_info,
    required this.pictures,
    required this.label,
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

class Attraction {
  String name, address;
  double lat, lon;
  List<Post> post_list;
  Attraction({
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
    required this.post_list
  });
}