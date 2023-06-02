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
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(96, 175, 245, 1),
            ),
            onPressed: () {
              Navigator.pop(context);
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
                  borderRadius: BorderRadius.circular(10.0), // 设置圆角半径为10.0
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "搜尋地點",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none, // 移除文本框的默认边框
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
                    return Column(
                      children: [
                        ListTile(
                          title: Text(location),
                          onTap: () {
                            Navigator.pop(context, location);
                          },
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15.0), // 设置上下边距
                          child: Divider(
                            // 添加蓝色底线
                            color: Color.fromRGBO(170, 227, 254, 1),
                            thickness: 1.0,
                          ),
                        ),
                      ],
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
              // Do something with returned data
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
        ));
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
