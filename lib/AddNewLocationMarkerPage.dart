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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('新建地標'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("輸入地點名稱"),
            TextField(),
            SizedBox(height: 16),
            Text("經度"),
            TextField(),
            SizedBox(height: 16),
            Text("緯度"),
            TextField(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: getImage,
              child: Text('選擇圖片'),
            ),
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200,
                    width: 200,
                  ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetLocationPage()),
                ).then((value) {
                  // Do something with returned data
                });
              },
              child: Text("選擇地點"),
            ),
          ],
        ),
      ),
    );
  }
}
