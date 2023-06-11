import 'package:flutter/material.dart';
import 'package:pet_app/PostPage.dart';
import 'PetApp.dart';
import 'ProfilePage.dart';
import 'ChatOverviewPage.dart';
import "HomePage.dart";

class MainPage extends StatefulWidget {
  final int current_index;
  const MainPage({super.key,required, required this.current_index });
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex = widget.current_index;
  final List<Widget> _pages = [
    HomePage(title: "Google Map"),
    // StoryPage(
    //   Post_list: _posts,
    //   Post_Index: 2,
    // ),
    PostPage(),
    ChatOverviewPage(),
    ProfilePage(
        Is_Me: true,
        followed: false,
        user: User(
            email: "", name: "", intro: "", locations: "0,0", password: "")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages[3] = ProfilePage(
        Is_Me: true,
        followed: false,
        user: User(
            email: "",
            name: "",
            intro: "",
            locations: "0,0",
            password: "")); //a little dirty but works
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 20),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_outlined,
              color: Colors.blue,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
              color: Colors.blue,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: Colors.blue, Icons.person_outlined),
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
