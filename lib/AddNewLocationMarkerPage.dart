import 'package:flutter/material.dart';
import 'SetLocationPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddNewLocationMarkerPage extends StatefulWidget {
  const AddNewLocationMarkerPage({super.key});

  @override
  State<AddNewLocationMarkerPage> createState() => _AddNewLocationMarkerPage();
}

class _AddNewLocationMarkerPage extends State<AddNewLocationMarkerPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
