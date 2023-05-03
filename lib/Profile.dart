import 'package:flutter/material.dart';
import 'CustomWidget.dart';
import 'EditPersonData.dart';
import 'main.dart';
import 'package:album_image/album_image.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.person});
  final UserDetail person;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustomWidget cw = new CustomWidget();
  String gender = "";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.person.name,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              profile_info(widget.person.photo, widget.person.posts_count, widget.person.follower, false),
              Text_title("飼主簡介"),
              Text_info("tttttttttttttttteeeeeeeeeeeeeeeeeeeesssssssssssssssssttttttttttttttt"),
              Text_title("寵物資料"),
              Pets_photo(widget.person.petdatas),
              Text_title("寵物相簿"),
              Album(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Posts',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }


  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Posts',
      style: optionStyle,
    ),
    Text(
      'Index 2: Message',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget profile_info(String file_name, int posts_count, int followers, bool is_user) {
    if (is_user){
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: cw.Profile_photo(35, file_name: file_name),
              flex: 1,
            ),
            Spacer(),
            Flexible(
              child: cw.Text_count("Follower", followers),
              flex: 1,
            ),
            Spacer(),
            Flexible(
              child: cw.Text_count("Posts", posts_count),
              flex: 1,
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: cw.Profile_photo(25, file_name: file_name),
            flex: 1,
            fit: FlexFit.loose,
          ),
          Spacer(),
          Flexible(
            child: Column(
              children: [
                cw.Text_count("Follower", followers),
                CustomButton(
                  label: 'Follow',
                  onPressed: () {},
                  height: 20,
                  width: 100,
                ),
              ],
            ),
            flex: 1,
            fit: FlexFit.loose,
          ),
          Spacer(),
          Flexible(
            child: Column(
              children: [
                cw.Text_count("Posts", posts_count),
                CustomButton(
                  label: 'Chats',
                  onPressed: () {},
                  height: 20,
                  width: 100,
                ),
              ],
            ),
            flex: 1,
            fit: FlexFit.loose,
          ),
        ],
      ),
    );
  }

  Widget Text_title(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Text_info(String info) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        )
      ),
      child: Text(
        info,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget Pets_photo(List<PetDetail> pets_list){
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Row(
        children: pets_list.map((pet) => cw.Profile_photo(35, file_name: pet.photo)).toList(),
      ),
    );
  }

  Widget Album(BuildContext context) {
    return Expanded(child: 
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return RawMaterialButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DetailsPage(
                //       imagePath: _images[index].imagePath,
                //       title: _images[index].title,
                //       photographer: _images[index].photographer,
                //       price: _images[index].price,
                //       details: _images[index].details,
                //       index: index,
                //     ),
                //   ),
                // );
              },
              child: Hero(
                tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(_images[index].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: _images.length,
        ),
      )
    ); 
  }
}

// from: https://github.com/kaycobad/gallery_app/tree/master/lib
class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    required this.imagePath,
    required this.price,
    required this.photographer,
    required this.title,
    required this.details,
  });
}

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/image/dog4.jpg',
    price: '\$20.00',
    photographer: 'Martin Andres',
    title: 'New Year',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog5.jpg',
    price: '\$10.00',
    photographer: 'Abraham Costa',
    title: 'Spring',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog6.jpg',
    price: '\$30.00',
    photographer: 'Jamie Bryan',
    title: 'Casual Look',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog7.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog8.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog9.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
];

