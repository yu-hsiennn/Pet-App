import 'dart:convert';
import 'PetApp.dart';
import 'package:flutter/material.dart';
import 'SetLocationPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddNewLocationMarkerPage extends StatefulWidget {
  const AddNewLocationMarkerPage({super.key});

  @override
  State<AddNewLocationMarkerPage> createState() => _AddNewLocationMarkerPage();
}

class _AddNewLocationMarkerPage extends State<AddNewLocationMarkerPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _placeNameController.dispose(); // 释放控制器资源
    _addressController.dispose(); // 释放控制器资源
    _longitudeController.dispose(); // 释放控制器资源
    _latitudeController.dispose(); // 释放控制器资源
    super.dispose();
  }

  void setLonLat(double lon, double lat) {
    setState(() {
      _longitudeController.text = '$lon'; // 将经度文本字段的值设置为0
      _latitudeController.text = '$lat'; // 将纬度文本字段的值设置为1
    });
  }

  Future<void> addAtraction_toserver(
      String place, String address, double lon, double lat) async {
    final response = await http.post(
      Uri.parse(PetApp.Server_Url + '/attraction'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': place,
        'location': address,
        'lat': lat,
        'lon': lon,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      print(responseData);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          '新建地標',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "地點名稱",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _placeNameController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(), // 设置为底线样式
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                hintText: '輸入地點名稱...',
              ),
            ),
            SizedBox(height: 16),
            Text(
              "地址",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(), // 设置为底线样式
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                hintText: '輸入地址...',
              ),
            ),
            SizedBox(height: 16),
            Text(
              "經度",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(), // 设置为底线样式
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                hintText: '輸入經度...',
              ),
            ),
            SizedBox(height: 16),
            Text(
              "緯度",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(), // 设置为底线样式
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                ),
                hintText: '輸入緯度...',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetLocationPage()),
                  ).then((value) {
                    // Do something with returned data
                    double lon = value[0];
                    double lat = value[1];
                    setLonLat(lon, lat);
                  });
                },
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return ClipRRect(
                          child: Image(
                            image: AssetImage('assets/map/map.png'),
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0), // 可選，設置圓角
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.5), // 調整淡化的透明度
                      child: Center(
                        child: Text(
                          '從地圖選擇',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Add padding to the button
                child: ElevatedButton(
                  onPressed: () {
                    String placeName = _placeNameController.text;
                    String address = _addressController.text;
                    String longitude = _longitudeController.text;
                    String latitude = _latitudeController.text;
                    addAtraction_toserver(placeName, address,
                        double.parse(longitude), double.parse(latitude));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set button shape to rounded rectangle
                    ),
                    primary: Color.fromRGBO(
                        96, 175, 245, 1), // Set button color to light blue
                    padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0), // Increase button size
                  ),
                  child: Text(
                    "完成",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
