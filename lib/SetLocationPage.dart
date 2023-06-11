import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_service.dart';

class SetLocationPage extends StatefulWidget {
  @override
  _SetLocationPageState createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  final Map<String, Marker> _markers = {};
  TextEditingController _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? mycontroller;
  List<double > location=[];
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 175, 245, 1),
          title: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "選擇地點",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black),
              ),
              Text(
                "選擇地點",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              location=[0,0];
              Navigator.pop(context, location);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, location);
              },
            ),
          ]
        ),
        
        body: Stack(
          children: [
            Expanded(
              child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                // onMapCreated: _onMapCreated,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  mycontroller = controller;
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(22.99749, 120.22062),
                  zoom: 15,
                ),
                markers: _markers.values.toSet(),
                onCameraIdle: () {
                  Future<LatLngBounds> bounds = mycontroller!.getVisibleRegion();
                  bounds.then((LatLngBounds boundsData) {
                    final lon = (boundsData.northeast.longitude + boundsData.southwest.longitude) / 2;
                    final lat = (boundsData.northeast.latitude + boundsData.southwest.latitude) / 2;
                    print("lon: $lon");
                    print("lat: $lat");
                    location=[lon,lat];
                  });
                },
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
            Center(
              child: Icon(Icons.location_on)
            )
          ],
        ),
      ),
    );
  }
}
