import 'package:flutter/material.dart';
import 'UserData.dart';
import 'ProfilePage.dart';
import 'ChatOverviewPage.dart';
import 'StoryPage.dart';
import 'PostClass.dart';
import "HomePage.dart";

//demo user with two pets
PetDetail demoPet1 = PetDetail(
    "Luchi", "Gold", "Male", 3, ["123", "456", "789"], "assets/image/dog1.jpg");
PetDetail demoPet2 = PetDetail(
    "Lushi", "Gold", "Female", 2, ["321", "987"], "assets/image/dog2.jpeg");

UserData demoUser1 = UserData(
  name: "peach",
  username: 'demouser',
  password: 'demopw',
  follower: 116,
  pet_count: 2,
  intro: "aasddf",
  photo: "assets/image/peach.jpg",
  petdatas: [demoPet1, demoPet2],
);

List<Post> _posts = [
  Post(
      poster: _users[0],
      post_info: "Hi! First Post!!",
      pictures: "assets/image/dog1.jpg",
      label: ['可愛', '調皮'],
      like_count: 251234,
      comments: [_comment[1], _comment[2], _comment[3], _comment[4]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "assets/image/dog4.jpg",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
];

List<UserData> _users = [
  UserData(
      name: "Bob",
      username: "bob",
      password: "123",
      photo: "assets/image/empty.jpg"),
  UserData(
      name: "Alice",
      username: "alice",
      password: "123",
      photo: "assets/image/peach.jpg"),
  UserData(
      name: "Joe",
      username: "joe",
      password: "123",
      photo: "assets/image/dog9.jpg"),
  UserData(
      name: "Oreo",
      username: "oreo",
      password: "123",
      photo: "assets/image/dog8.jpg"),
  UserData(
      name: "Bear",
      username: "bear",
      password: "123",
      photo: "assets/image/dog7.jpg"),
];

List<Comment> _comment = [
  Comment(user: _users[0], comment_info: "how are you", like_count: 19),
  Comment(user: _users[1], comment_info: "how are you", like_count: 17),
  Comment(user: _users[2], comment_info: "how are you", like_count: 10),
  Comment(user: _users[3], comment_info: "how are you", like_count: 11),
  Comment(user: _users[4], comment_info: "Cool!", like_count: 14),
  Comment(user: _users[2], comment_info: "OMG! So Cute!!!", like_count: 1285),
  Comment(
      user: _users[3],
      comment_info: "I totally agree with you!!",
      like_count: 12),
];

List<Chat> chatList = [
  Chat(
      name: 'someFriend',
      lastActive: DateTime.now(),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.parse('2023-05-04 12:25'),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.parse('2023-05-04 12:24'),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.parse('2023-05-04 10:24'),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.parse('2023-05-02 10:24'),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.now(),
      lastMessage: 'somelastmessage'),
  Chat(
      name: 'someFriend',
      lastActive: DateTime.now(),
      lastMessage: 'somelastmessage'),
];

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});
  final UserData user;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(title: "Google Map"),
    StoryPage(
      Post_list: _posts,
      Post_Index: 2,
    ),
    ChatOverviewPage(chats: chatList),
    ProfilePage(person: demoUser1),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages[3] = ProfilePage(person: widget.user); //a little dirty but works
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PETMATCH',
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 20),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          'Placeholder Widget',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
