import 'dart:async';
import 'package:flutter/material.dart';
import 'PostClass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'location_service.dart';


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
        ],
      ),
    );
  }

}