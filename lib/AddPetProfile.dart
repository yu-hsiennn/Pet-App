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
            bottom:
                BorderSide(width: 1.0, color: Color.fromRGBO(170, 227, 254, 1)),
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
    int rows = (items.length / 4).ceil();
    List<Widget> rowsList = [];

    for (int i = 0; i < rows; i++) {
      List<Widget> buttonsList = [];

      for (int j = i * 4; j < (i + 1) * 4 && j < items.length; j++) {
        buttonsList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: OutlinedButton(
              onPressed: () {
                if (selectedItems.contains(items[j])) {
                  selectedItems.remove(items[j]);
                } else {
                  if (selectedItems.length < 4) {
                    selectedItems.add(items[j]);
                  }
                }
                setState(() {});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 8.0)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(170, 227, 254, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                items[j],
                style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                    title: Text(
                      "新增label",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: TextField(
                      controller: _newItemController,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 去除边框
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(
                                  170, 227, 254, 1)), // 设置底线颜色为蓝色
                        ),
                        hintText: '輸入新label...',
                      ),
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
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(170, 227, 254, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
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
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              '新建寵物資訊',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Color.fromRGBO(96, 175, 245, 1),
                ),
                onPressed: () {},
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "寵物名",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // 去除边框
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                    ),
                    hintText: '輸入寵物名稱...',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "寵物品種",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // 去除边框
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                    ),
                    hintText: '輸入寵物品種...',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "寵物年齡",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // 去除边框
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                    ),
                    hintText: '輸入寵物年齡...',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "寵物性別",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // 去除边框
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                    ),
                    hintText: '輸入寵物性別...',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "寵物個性標籤",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              ],
            ),
          ),
        ));
  }
}
