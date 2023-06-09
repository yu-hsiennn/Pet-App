import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'PetApp.dart';
import 'StoryPage.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({super.key, required this.attraction});
  final Attraction attraction;

  @override
  State<AttractionPage> createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> {
  void _onItemTapped(int index) {

  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 0)),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 1)),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MainPage(current_index: 2)),
      );
      break;
    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 3)),
      );
      break;
  }
}
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 175, 245, 1),
          title: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "PETSHARE",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black),
              ),
              Text(
                "PETSHARE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
          automaticallyImplyLeading: false,
        ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      child: Text(
                        widget.attraction.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                      child: Text(
                        widget.attraction.address,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              // Icon(Icons.settings),
              SizedBox(width: 12),
            ],
          ),
          buildImages(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.yellow,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedIconTheme: IconThemeData(size: 20),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
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
    ),
  );

  Widget buildImages() => SliverToBoxAdapter(
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: widget.attraction.posts.length,
      itemBuilder: (context, index) {
        return RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryPage(
                      Post_list: widget.attraction.posts,
                      Post_Index: index,
                    )));
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Card(
              child: Image.network(
                  widget.attraction.posts[index].post_picture,
                  fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}
