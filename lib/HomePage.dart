import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_service.dart';
import 'AttractionPage.dart';
import 'PetApp.dart';
import 'dart:convert';
import 'package:image/image.dart' as IMG;
import 'package:http/http.dart' as http;
import 'package:custom_marker/marker_icon.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Map<String, Marker> _markers = {};
//   TextEditingController _searchController = TextEditingController();
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   String AttractionUrl = PetApp.Server_Url + '/attraction';
//   late Future<List<Attraction>> _attractionsFuture;
//   Set<Marker> _currentMarkers = {};

//   @override
//   void initState() {
//     super.initState();
//     _attractionsFuture = getAttractions();
//   }

//   Future<List<Attraction>> getAttractions() async {
//     List<Attraction> attractions = [];
//     final response = await http.get(Uri.parse(AttractionUrl), headers: {
//       'accept': 'application/json',
//     });

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       for (var attraction in responseData) {
//         List<Posts> posts = [];
//         for (var post in attraction['posts']) {
//           posts.add(
//             Posts(
//               owner_id: post["owner_id"], 
//               content: post["content"], 
//               id: post["id"], 
//               timestamp: post["timestamp"],
//               response_to: post['response_to']
//             )
//           );
//         }
//         attractions.add(
//           Attraction(
//             name: attraction['name'],
//             address: attraction['location'],
//             lat: attraction['lat'],
//             lon: attraction['lon'],
//             posts: posts,
//             id: attraction['id']
//           )
//         );
//       }
      
//       PetApp.Attractions = attractions;
//       print(responseData);
//       return attractions;
//     } else {
//       print(
//           'Request failed with status: ${json.decode(response.body)['detail']}.');
//       return [];
//     }
//   }

//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     _controller.complete(controller);
//     await updateMarkers(); 
//     // _markers.clear();
//     // for (final attractions in PetApp.Attractions) {
//     //   addMarker(attractions);
//     // }
//   }

//   Future<void> updateMarkers() async {
//     final attractions = await _attractionsFuture;
//     final newMarkers = attractions.map((attraction) {
//       return Marker(
//         markerId: MarkerId(attraction.name),
//         position: LatLng(attraction.lat, attraction.lon),
//         // Set other properties for the marker as needed
//       );
//     }).toSet();

//     setState(() {
//       _currentMarkers = newMarkers;
//     });
//   }

//   Future<void> _goToPlace(Map<String, dynamic> place) async {
//     final double lat = place['geometry']['location']['lat'];
//     final double lng = place['geometry']['location']['lng'];

//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(lat, lng), zoom: 12),
//       ),
//     );
//   }

//   addMarker(Attraction attraction) async {
//     if (attraction.posts.length == 0) return;
//     int _size = attraction.posts.length < 5
//         ? 100
//         : attraction.posts.length * 25;
//     var markerIcon = await MarkerIcon.downloadResizePictureCircle(
//         attraction.posts[0].post_picture == "" ? "https://s28489.pcdn.co/wp-content/uploads/2021/04/Dog-park-2-May-16.jpg.optimal.jpg"
//         : attraction.posts[0].post_picture,
//         size: _size,
//         addBorder: true,
//         borderColor: Colors.blue,
//         borderSize: 15);
//     var marker = Marker(
//       markerId: MarkerId(attraction.name),
//       position: LatLng(attraction.lat, attraction.lon),
//       icon: markerIcon,
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => AttractionPage(
//                     name: attraction.name,
//                     address: attraction.address,
//                     Post_list: attraction.posts)));
//       },
//     );
//     setState(() {
//       _markers[attraction.name] = marker;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var init_latlng = PetApp.CurrentUser.locations.split(",");
//     print(PetApp.CurrentUser.locations);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(96, 175, 245, 1),
//           title: Center(
//               child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Text(
//                 "PETSHARE",
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     foreground: Paint()
//                       ..style = PaintingStyle.stroke
//                       ..strokeWidth = 1
//                       ..color = Colors.black),
//               ),
//               Text(
//                 "PETSHARE",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           )),
//           automaticallyImplyLeading: false,
//         ),
//         body: Stack(
//           children: [
//             GoogleMap(
//               myLocationButtonEnabled: false,
//               myLocationEnabled: true,
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   double.parse(init_latlng[0]), 
//                   double.parse(init_latlng[1])
//                 ),
//                 zoom: 13.5,  
//               ),
//               markers: _markers.values.toSet(),
//             ),
//             Positioned(
//               top: 10,
//               right: 15,
//               left: 15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                       color: Color.fromRGBO(96, 175, 245, 1)), // 设置边框颜色为蓝色
//                   borderRadius: BorderRadius.circular(10.0), // 设置圆角半径为10.0
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: TextField(
//                         cursorColor: Color.fromRGBO(96, 175, 245, 1),
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.go,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 15),
//                             hintText: "搜尋"),
//                         controller: _searchController,
//                         textCapitalization: TextCapitalization.words,
//                         onChanged: (value) {
//                           print(value);
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: IconButton(
//                         color: Color.fromRGBO(96, 175, 245, 1),
//                         onPressed: () async {
//                           var place = await LocationService()
//                               .getPlace(_searchController.text);
//                           _goToPlace(place);
//                         },
//                         icon: Icon(Icons.search),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             FutureBuilder<List<Attraction>>(
//               future: _attractionsFuture,
//               builder: (BuildContext context, AsyncSnapshot<List<Attraction>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No attractions found.'));
//                 } else {
//                   final attractions = snapshot.data!;
//                   _markers.clear();
//                   for (final attraction in attractions) {
//                     addMarker(attraction);
//                   }
//                   return SizedBox.shrink(); // Return an empty widget as we have already updated the markers
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  String AttractionUrl = PetApp.Server_Url + '/attraction';

  Future<void> GetAttraction() async {
    List<Attraction> _attractions = [];
    final response = await http.get(Uri.parse(AttractionUrl), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var attraction in responseData) {
        List<Posts> _post = [];
        for (var post in attraction['posts']) {
          _post.add(
            Posts(
              owner_id: post["owner_id"], 
              content: post["content"], 
              id: post["id"], 
              timestamp: post["timestamp"],
              response_to: post['response_to']
            )
          );
        }
        _attractions.add(
          Attraction(
            name: attraction['name'],
            address: attraction['location'],
            lat: attraction['lat'],
            lon: attraction['lon'],
            posts: _post,
            id: attraction['id']
          )
        );
      }
      
      PetApp.Attractions = _attractions;
      print(responseData);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _markers.clear();
    for (final attractions in PetApp.Attractions) {
      addMarker(attractions);
    }
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }

  addMarker(Attraction attraction) async {
    if (attraction.posts.length == 0) return;
    int _size = attraction.posts.length < 5
        ? 100
        : attraction.posts.length * 25;
    var markerIcon = await MarkerIcon.downloadResizePictureCircle(
        attraction.posts[0].post_picture == "" ? "https://s28489.pcdn.co/wp-content/uploads/2021/04/Dog-park-2-May-16.jpg.optimal.jpg"
        : attraction.posts[0].post_picture,
        size: _size,
        addBorder: true,
        borderColor: Colors.blue,
        borderSize: 15);
    var marker = Marker(
      markerId: MarkerId(attraction.name),
      position: LatLng(attraction.lat, attraction.lon),
      icon: markerIcon,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AttractionPage(
                    name: attraction.name,
                    address: attraction.address,
                    Post_list: attraction.posts)));
      },
    );

    _markers[attraction.name] = marker;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var init_latlng = PetApp.CurrentUser.locations.split(",");
    print(PetApp.CurrentUser.locations);
    return SafeArea(
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
        body: Stack(
          children: [
            Expanded(
              child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(init_latlng[0]), 
                    double.parse(init_latlng[1])
                  ),
                  zoom: 13.5,  
                ),
                markers: _markers.values.toSet(),
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromRGBO(96, 175, 245, 1)), // 设置边框颜色为蓝色
                  borderRadius: BorderRadius.circular(10.0), // 设置圆角半径为10.0
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: Color.fromRGBO(96, 175, 245, 1),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "搜尋"),
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
                        color: Color.fromRGBO(96, 175, 245, 1),
                        onPressed: () async {
                          var place = await LocationService()
                              .getPlace(_searchController.text);
                          _goToPlace(place);
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

