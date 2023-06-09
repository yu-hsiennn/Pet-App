import 'package:flutter/material.dart';

// --------------------------------------------------------------
class PetApp {
  // global variable
  static User CurrentUser =
      new User(email: "", name: "", intro: "", locations: "0,0", password: "");

  static List<Attraction> Attractions = [];

  // Server Url for android emulator
  // static String Server_Url = "http://10.0.2.2:8000";
  static String Server_Url = "http://172.20.10.4:8000";
}

// -----------------------class define-----------------------------
class User {
  String name,
      email,
      intro,
      profile_picture,
      authorization,
      password,
      locations;
  List<Pet> pets;
  List<String> Following, Follower;
  List<Posts> posts;
  List<Comment> comments;
  User(
      {required this.email,
      required this.name,
      required this.intro,
      required this.locations,
      required this.password,
      this.pets = const [],
      this.Follower = const [],
      this.Following = const [],
      this.profile_picture = "",
      this.authorization = "",
      this.posts = const [],
      this.comments = const []});
}

class Like {
  String liker;
  int timestamp;
  Like({required this.liker, required this.timestamp});
}

class Posts {
  String owner_id;
  String content, post_picture, label;
  int response_to, id, timestamp;
  List<Like> Likes;
  List<Comment> Comments;
  Posts(
      {required this.owner_id,
      this.response_to = 0,
      required this.content,
      this.label = "",
      required this.id,
      this.post_picture = "",
      this.Likes = const [],
      required this.timestamp,
      this.Comments = const []});
}

class Comment {
  int timestamp, response_to;
  String content, owner_id;
  Comment(
      {required this.owner_id,
      required this.content,
      required this.timestamp,
      required this.response_to});
}

class Pet {
  String owner, name, breed, gender, birthday, personality_labels, picture;
  int id;
  Pet(
      {required this.owner,
      required this.name,
      required this.breed,
      required this.birthday,
      required this.personality_labels,
      required this.gender,
      required this.id,
      required this.picture});
}

class Attraction {
  String name, address;
  double lat, lon;
  List<Posts> posts;
  int id;
  Attraction(
      {required this.name,
      required this.address,
      required this.lat,
      required this.lon,
      required this.posts,
      required this.id});
}

class Chat {
  int id;
  String name, ownerId;
  String lastMessage;
  DateTime lastActive;
  List<Message> chatContent = [];
  Chat(
      {required this.id,
      required this.name,
      required this.lastMessage,
      required this.lastActive,
      required this.ownerId});
}

class Message {
  String text;
  String sender;
  bool isPicture;
  DateTime sentTime;

  Message(
      {required this.text,
      required this.sender,
      required this.isPicture,
      required this.sentTime});
}

// -----------------custom widget-------------------------
class CustomWidget {
  CustomWidget();

  // follower or following or posts widget
  Widget Text_count(String title, int counts) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            counts.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // profile photo
  Widget Profile_photo(int framesize,
      {String file_name = "assets/image/empty.jpg"}) {
    String _file_name = file_name.isEmpty
        ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
        : file_name;
    return CircleAvatar(
      radius: framesize.toDouble(),
      backgroundImage: NetworkImage(
        _file_name,
      ),
    );
  }

  // Label
  Widget Labels(String label) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Text(label),
    );
  }
}

// ---------------custom button--------------------------
class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final List<Color> tappedDownColors;
  final List<Color> regularColors;
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.tappedDownColors = const [
      Color.fromRGBO(159, 89, 99, 1),
      Color.fromRGBO(168, 124, 94, 1),
    ],
    this.regularColors = const [
      Color.fromRGBO(96, 175, 245, 1),
      Color.fromRGBO(170, 227, 254, 1),
    ],
    this.height = 60,
    this.width,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isTappedDown = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isTappedDown = false;
          });
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() {
            _isTappedDown = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isTappedDown
                    ? widget.tappedDownColors
                    : widget.regularColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ]),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: widget.height,
          width: widget.width,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
