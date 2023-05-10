import 'dart:async';
import 'package:flutter/material.dart';
import 'PostClass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'location_service.dart';
import 'AttractionPage.dart';
import 'UserData.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  // final List<Post> Post_list;
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Marker> _markers = {};
  TextEditingController _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng), 
          zoom: 16
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              // onMapCreated: _onMapCreated,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.99749, 120.22062),
                zoom: 15,
              ),
              markers: _markers.values.toSet(),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search Here"
                      ),
                      controller: _searchController,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () async {
                        var place = await LocationService().getPlace(_searchController.text);
                        _goToPlace(place);
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttractionPage(Post_list: _posts)
                  )
                );
              },
            )
          ),
        ],
      ),
    );
  }

}


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
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
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
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
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
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
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
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "assets/image/dog5.jpg",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]])
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
