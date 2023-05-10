import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostPicturePage extends StatefulWidget {
  const UploadPostPicturePage({super.key});

  @override
  State<UploadPostPicturePage> createState() => _UploadPostPicturePageState();
}

class _UploadPostPicturePageState extends State<UploadPostPicturePage> {
  File? _imageFile;

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      } else {
        _imageFile = null;
      }
    });
  }

  void _clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
              )
            else
              const Text('No image selected'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _clearImage,
                  child: const Text('Clear Image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
