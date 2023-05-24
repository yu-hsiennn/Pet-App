import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'location_service.dart';
import 'AttractionPage.dart';
import 'PetApp.dart';
import 'package:image/image.dart' as IMG;
import 'package:custom_marker/marker_icon.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
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
    _controller.complete(controller);
    _markers.clear();
    for (final attractions in _attraction) {
      addMarker(attractions);
    }
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng), 
          zoom: 13
        ),
      ),
    );
  }

  addMarker(Attraction attraction) async {
    int _size = attraction.post_list.length < 5? 200 : attraction.post_list.length * 50;
    var markerIcon = await MarkerIcon.downloadResizePictureCircle(
                  attraction.post_list[0].pictures,
                  size: _size,
                  addBorder: true,
                  borderColor: Colors.blue,
                  borderSize: 15);
    var marker = Marker(
      markerId: MarkerId(attraction.name),
      position: LatLng(attraction.lat, attraction.lon),
      icon: markerIcon,
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttractionPage(
              name: attraction.name,
              address: attraction.address,
              Post_list: attraction.post_list)
          )
        );
      },
    );

    _markers[attraction.name] = marker;
    setState(() {
    });

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
              onMapCreated: _onMapCreated,
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
          // Positioned(
          //   bottom: 10,
          //   left: 15,
          //   child: IconButton(
          //     icon: Icon(Icons.send),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => AttractionPage(Post_list: _posts)
          //         )
          //       );
          //     },
          //   )
          // ),
        ],
      ),
    );
  }

}



List<Post> _posts = [
  Post(
      poster: _users[0],
      post_info: "Hi! First Post!!",
      pictures: "https://humaneheroes.org/wp-content/uploads/2019/09/txhh_best-practices-when-taking-dog-park.png",
      label: ['可愛', '調皮'],
      like_count: 251234,
      comments: [_comment[1], _comment[2], _comment[3], _comment[4]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "https://s28489.pcdn.co/wp-content/uploads/2021/04/Dog-park-2-May-16.jpg.optimal.jpg",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1324099927/photo/friends-red-cat-and-corgi-dog-walking-in-a-summer-meadow-under-the-drops-of-warm-rain.jpg?s=612x612&w=0&k=20&c=ZQiqn4SPj_7WhjhbahGJ1UwaJMrwuuSkJRjYAi9YYx0=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
      Post(
      poster: _users[0],
      post_info: "Hi! First Post!!",
      pictures: "https://media.istockphoto.com/id/489272417/photo/cat-and-dog-sitting-together.jpg?s=612x612&w=0&k=20&c=fc5QMPfrxsmC6seeCp-O-KcwNgUIsXu4md3xAGq-Iww=",
      label: ['可愛', '調皮'],
      like_count: 251234,
      comments: [_comment[1], _comment[2], _comment[3], _comment[4]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "https://media.istockphoto.com/id/1252455620/photo/golden-retriever-dog.jpg?s=612x612&w=0&k=20&c=3KhqrRiCyZo-RWUeWihuJ5n-qRH1MfvEboFpf5PvKFg=",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1285465107/photo/loyal-golden-retriever-dog-sitting-on-a-green-backyard-lawn-looks-at-camera-top-quality-dog.jpg?s=612x612&w=0&k=20&c=S2pHWsbQwMk82qowUVsz-L9FsOB_RAGv-mgrX12IELU=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1310331783/photo/fluffy-friends-a-corgi-dog-and-a-tabby-cat-sit-together-in-a-sunny-spring-meadow.jpg?s=612x612&w=0&k=20&c=zkGrCtOa8-62aIbkIHtIwDr0gqmiexk5-kWX7VRzo6A=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1227427227/photo/funny-beagle-tricolor-dog-lying-or-sleeping-paws-up-on-the-spine-on-the-city-park-green-grass.jpg?s=612x612&w=0&k=20&c=bUB1TUnoWZU6-2ZifqZGNhg_rLAmYFKUdDU45RmWhQs=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[0],
      post_info: "Hi! First Post!!",
      pictures: "https://media.istockphoto.com/id/1317523051/photo/young-woman-takes-selfie-with-her-dog.jpg?s=612x612&w=0&k=20&c=2No93m_ZD6dfMa_LunQ6msJMalgm4154Srsy52yGeko=",
      label: ['可愛', '調皮'],
      like_count: 251234,
      comments: [_comment[1], _comment[2], _comment[3], _comment[4]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "https://media.istockphoto.com/id/1224927400/photo/happy-woman-embracing-beagle-dog-in-park.jpg?s=612x612&w=0&k=20&c=U4YFNK_Vqanj4IL-K-s4eGD4_LKqMIyx2Im4Ojcar4c=",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1173954887/photo/hungry-or-thirsty-dog-fetches-metal-bowl-to-get-feed-or-water.jpg?s=612x612&w=0&k=20&c=tGsVtKRDMCM2PFC8YYeLZ5WBzWIQrVFVy9xHALNn3yY=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1178352376/photo/happy-and-cheerful-dog-playing-fetch-with-toy-bone-at-backyard-lawn.jpg?s=612x612&w=0&k=20&c=UWUFO0h58i5qY8CNeVLbHixHsm7lNoM3OEsOHl7MeSY=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/583689556/photo/best-friends.jpg?s=612x612&w=0&k=20&c=8_aa7cNcJkqoMB_-ImmCtb-_GHZmDYa8y9sE3rK4uwE=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "https://media.istockphoto.com/id/1248789778/photo/funny-playful-happy-smiling-pet-dog-puppy-running-jumping-in-the-grass.jpg?s=612x612&w=0&k=20&c=m3oafXgrEtfsYkbVuUGgOYstvq_7kLE-UU56FUTsMFk=",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1172407219/photo/two-golden-retriever-dogs-running-after-each-other.jpg?s=612x612&w=0&k=20&c=uDpyVuJvqMJzY7-n8u0tnI2zGoy8xM_-V-lATn_qXUY=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/505823546/photo/dog-in-the-city-park.jpg?s=612x612&w=0&k=20&c=8uqEErNfuIHTFkIwZn74h5lylD8edEtw3rOvtoAlKzw=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1399405977/photo/couple-of-friends-a-cat-and-a-dog-run-merrily-through-a-summer-flowering-meadow.jpg?s=612x612&w=0&k=20&c=GQLemb0zUq4N59Ik2LLWIXzLuzCMzzphtkD8c7VSULY=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[0],
      post_info: "Hi! First Post!!",
      pictures: "https://media.istockphoto.com/id/481634156/photo/dogs-playing.jpg?s=612x612&w=0&k=20&c=9iNKfU0IVVDIUHjw_qfoHfcj0cp9rywySXlSntiNhLs=",
      label: ['可愛', '調皮'],
      like_count: 251234,
      comments: [_comment[1], _comment[2], _comment[3], _comment[4]]),
  Post(
      poster: _users[2],
      post_info: "Hi! Nice to meet all!!",
      pictures: "https://media.istockphoto.com/id/618635454/photo/happy-boy-with-a-beautiful-dog.jpg?s=612x612&w=0&k=20&c=mfBZ6feMbd9_oaw9hc1VTAoYY-elqB4PBuFc7X_hChI=",
      label: ['好吃', '美味'],
      like_count: 34,
      comments: [
        _comment[1],
        _comment[0],
      ]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1155876248/photo/brown-dog-scratching-itself.jpg?s=612x612&w=0&k=20&c=WdOeYFo9L8OMjm9vbC0YKI_hSzs6JMKuFa4sK3iDAtI=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/1248529734/photo/golden-retriever-in-the-field-with-yellow-flowers.jpg?s=612x612&w=0&k=20&c=DQhfvzclkW-CJRE4vlJAG35PnDIewKgRO5zlBRif1Gg=",
      label: ['不乖就是備用糧食'],
      like_count: 251,
      comments: [_comment[5], _comment[6]]),
  Post(
      poster: _users[4],
      post_info: "So hot!!",
      pictures: "https://media.istockphoto.com/id/171155760/photo/dogs-in-the-forest.jpg?s=612x612&w=0&k=20&c=YxklqBOaAaH0t40TpvcuvjQLjkJ_XAkb4FlS5snFe5E=",
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

List<Post> _posts1 = [_posts[0], _posts[1], _posts[2], _posts[3], _posts[4], _posts[5], _posts[6], _posts[7]];
List<Post> _posts2 = [_posts[8], _posts[9], _posts[10], _posts[11], _posts[12]];
List<Post> _posts3 = [_posts[13], _posts[14], _posts[15], _posts[16], _posts[17], _posts[18], _posts[19], _posts[20]];

List<Attraction> _attraction = [
  Attraction(
    name: "榕園", 
    address: "701台南市東區大學路1號成功大學光復校區", 
    lat: 23.00030964815583, 
    lon: 120.21611698468836, 
    post_list: _posts1
  ),
  Attraction(
    name: "台南公園", 
    address: "704台南市北區公園南路89號", 
    lat: 23.002256314070294, 
    lon: 120.21165637105577, 
    post_list: _posts2
  ),
  Attraction(
    name: "東興公園", 
    address: "701台南市東區", 
    lat: 22.997483245303513, 
    lon: 120.22540366637456, 
    post_list: _posts3
  )
];