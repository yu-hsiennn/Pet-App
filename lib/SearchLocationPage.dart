import 'dart:convert';
import 'package:flutter/material.dart';
import 'AddNewLocationMarkerPage.dart';
import 'PetApp.dart';
import 'package:http/http.dart' as http;

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPage();
}

class _SearchLocationPage extends State<SearchLocationPage> {
  String searchText = "";

  Future<void> getAttractions() async {
    List<Attraction> _attraction = [];
    final response =
        await http.get(Uri.parse(PetApp.Server_Url + '/attraction'), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      List<Posts> _post = [];
      final responseData = json.decode(response.body);
      for (var attraction in responseData) {
        for (var post in attraction['posts']) {
          _post.add(Posts(
              owner_id: post["owner_id"],
              content: post["content"],
              id: post["id"],
              timestamp: post["timestamp"]));
        }
        _attraction.add(Attraction(
            name: attraction['name'],
            address: attraction['location'],
            lon: attraction['lon'],
            lat: attraction['lat'],
            posts: _post,
            id: attraction['id']));
      }

      PetApp.Attractions = _attraction;
      print(responseData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(96, 175, 245, 1),
          ),
          onPressed: () {
            Navigator.pop(context, ['新增地點', -1]);
          },
        ),
        title: Text(
          '選擇地點',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 247, 252, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "搜尋地點",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: getAttractions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (PetApp.Attractions == null) {
                  return Center(child: Text('No attractions found.'));
                } else {
                  return ListView.builder(
                    itemCount: PetApp.Attractions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String location =
                          PetApp.Attractions[index].name;
                      final int location_id =
                          PetApp.Attractions[index].id;
                      if (searchText.isNotEmpty &&
                          !location
                              .toLowerCase()
                              .contains(searchText.toLowerCase())) {
                        return SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(location),
                              onTap: () {
                                Navigator.pop(
                                    context, [location, location_id]);
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              child: Divider(
                                color: Color.fromRGBO(170, 227, 254, 1),
                                thickness: 1.0,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNewLocationMarkerPage()),
          ).then((value) {
            getAttractions();
            setState(() {});
          });
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(170, 227, 254, 1)),
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(
          '新建地標',
          style: TextStyle(fontSize: 16),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }
}
