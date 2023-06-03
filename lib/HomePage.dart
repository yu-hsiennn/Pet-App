import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    int _size = attraction.posts.length < 5
        ? 100
        : attraction.posts.length * 25;
    var markerIcon = await MarkerIcon.downloadResizePictureCircle(
        attraction.posts[0].Files[0].file_path,
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

