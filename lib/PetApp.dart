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

  PetDetail(
      {required this.name,
      required this.breed,
      required this.gender,
      required this.age,
      required this.personality_lable,
      required this.photo});
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
  Attraction(
      {required this.name,
      required this.address,
      required this.lat,
      required this.lon,
      required this.post_list});
}

// --------------------------------------------------------------
class PetApp {
  static User CurrentUser =
      new User(email: "", name: "", intro: "", birthday: "", password: "");
}

class User {
  String name, email, intro, birthday, password, profile_picture, authorization;
  List<Pet> pets;
  List<User> Following, Follower;
  User({
    required this.email,
    required this.name,
    required this.intro,
    required this.birthday,
    required this.password,
    this.pets = const [],
    this.Follower = const [],
    this.Following = const [],
    this.profile_picture = "",
    this.authorization = "",
  });
}

class Like {
  String liker;
  int timestamp;
  Like({required this.liker, required this.timestamp});
}

class _File {
  String file_ending, user, file_path;
  int post, pet, message, id;
  _File(
      {required this.file_ending,
      required this.id,
      required this.file_path,
      this.message = 0,
      required this.user,
      this.post = 0,
      this.pet = 0});
}

class Posts {
  String owner_id, content;
  int response_to, id, timestamp;
  List<Like> Likes;
  List<_File> Files;
  Posts(
      {required this.owner_id,
      this.response_to = 0,
      required this.content,
      required this.id,
      this.Files = const [],
      this.Likes = const [],
      required this.timestamp});
}

class Pet {
  String owner, name, breed, gender, birthday, personality_labels;
  int id;
  List<_File> Files;
  Pet(
      {required this.owner,
      required this.name,
      required this.breed,
      required this.birthday,
      required this.personality_labels,
      required this.gender,
      required this.id,
      this.Files = const []});
}
// -----------------------
