import 'package:flutter/material.dart';
import 'UserData.dart';
import 'ProfilePage.dart';
import 'ChatOverviewPage.dart';

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
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    PlaceholderWidget(Colors.blue),
    PlaceholderWidget(Colors.orange),
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
