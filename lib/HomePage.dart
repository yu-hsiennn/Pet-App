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
        CameraPosition(target: LatLng(lat, lng), zoom: 14.5),
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
                    attraction: attraction)));
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
                  zoom: 14.5,  
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
                      color: Color.fromRGBO(96, 175, 245, 1)),
                  borderRadius: BorderRadius.circular(10.0),
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

