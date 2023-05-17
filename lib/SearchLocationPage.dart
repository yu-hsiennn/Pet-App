import 'package:flutter/material.dart';
import 'AddNewLocationMarkerPage.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPage();
}

class _SearchLocationPage extends State<SearchLocationPage> {
  String searchText = "";
  List<String> locationList = [
    "New York City",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Philadelphia",
    "San Antonio",
    "San Diego",
    "Dallas",
    "San Jose",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('選擇地點'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                searchText = "";
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search location",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locationList.length,
              itemBuilder: (BuildContext context, int index) {
                final String location = locationList[index];
                if (searchText.isNotEmpty &&
                    !location
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return SizedBox.shrink();
                } else {
                  return ListTile(
                    title: Text(location),
                    onTap: () {
                      Navigator.pop(context, location);
                    },
                  );
                }
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Location"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewLocationMarkerPage()),
              ).then((value) {
                // Do something with returned data
              });
            },
          ),
        ],
      ),
    );
  }
}
    
    // return Scaffold(
      
    //     body: TextButton(
    //   onPressed: () {
    //     Navigator.pop(context, '返回值');
    //   },
    //   child: Text('返回'),
    //  ));
//   }
// }
