import 'dart:io';
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
