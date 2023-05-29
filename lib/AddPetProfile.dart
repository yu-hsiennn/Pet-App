import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SetLocationPage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPetProfilePage extends StatefulWidget {
  const AddPetProfilePage({super.key});

  @override
  State<AddPetProfilePage> createState() => _AddPetProfilePage();
}

class _AddPetProfilePage extends State<AddPetProfilePage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _newItemController = TextEditingController();

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

  List<String> selectedItems = [];

  Widget buildSelectedField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black),
          ),
        ),
        child: Row(
          children: [
            Text(selectedItems.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget buildLabelField(List<String> items) {
    int rows = (items.length / 5).ceil();
    List<Widget> rowsList = [];

    for (int i = 0; i < rows; i++) {
      List<Widget> buttonsList = [];

      for (int j = i * 5; j < (i + 1) * 5 && j < items.length; j++) {
        buttonsList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: OutlinedButton(
              onPressed: () {
                if (selectedItems.contains(items[j])) {
                  selectedItems.remove(items[j]);
                } else {
                  if (selectedItems.length < 5) {
                    selectedItems.add(items[j]);
                  }
                }
                setState(() {});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 8.0)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 1.0, color: Colors.grey)),
              ),
              child: Text(
                items[j],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        );
      }

      rowsList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttonsList,
        ),
      );
    }

    // 加號按鈕
    rowsList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                // 彈出對話框輸入新項目
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("新增項目"),
                    content: TextField(
                      controller: _newItemController,
                      decoration: InputDecoration(hintText: "請輸入新項目"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("取消"),
                      ),
                      TextButton(
                        onPressed: () {
                          String newItem = _newItemController.text.trim();
                          if (newItem.isNotEmpty) {
                            items.add(newItem);

                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text("確定"),
                      ),
                    ],
                  ),
                );
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 1.0, color: Colors.grey)),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      // height: 50,

      child: Column(
        children: rowsList,
      ),
    );
  }

  List<String> items = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('新建寵物資訊'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("寵物名稱"),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '輸入寵物名稱...',
                  ),
                ),
                SizedBox(height: 16),
                Text("寵物品種"),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '輸入寵物品種...',
                  ),
                ),
                SizedBox(height: 16),
                Text("寵物年齡"),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '輸入寵物年齡...',
                  ),
                ),
                SizedBox(height: 16),
                Text("寵物性別"),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '輸入寵物性別...',
                  ),
                ),
                SizedBox(height: 16),
                Text("寵物個性標籤"),
                buildSelectedField(),
                buildLabelField(items),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPetProfilePage()),
                    ).then((value) {
                      // Do something with returned data
                      setState() {}
                      ;
                    });
                  },
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return ClipRRect(
                            child: Image(
                              image:
                                  AssetImage('assets/image/NonePetPicture.png'),
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.circular(10.0), // 可選，設置圓角
                          );
                        },
                      ),
                    ],
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
                        primary:
                            Colors.lightBlue, // Set button color to light blue
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 16.0), // Increase button size
                      ),
                      child: Text(
                        "完成",
                        style: TextStyle(
                          fontSize: 18.0, // Set font size
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
