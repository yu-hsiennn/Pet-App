import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class SetLocationPage extends StatefulWidget {
  @override
  _SetLocationPageState createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  List<File> images = [];

  void _loadImages() async {
    // Get all the image files in the device
    List<FileSystemEntity> files =
        Directory('/storage/emulated/0/DCIM/Camera').listSync();
    for (var file in files) {
      if (file is File && file.path.endsWith('.jpg')) {
        // Resize the image to save memory
        File resizedImage = await FlutterNativeImage.compressImage(file.path,
            quality: 50, percentage: 50);

        // Add the image to the list
        setState(() {
          images.add(resizedImage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Images'),
      ),
      body: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Image.file(
            images[index],
            fit: BoxFit.cover,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadImages,
        child: Icon(Icons.photo_library),
      ),
    );
  }
}
