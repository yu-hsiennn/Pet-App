import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String pet_name = '';
  String pet_breed = '';
  String pet_gender = '';
  String pet_birthday = '';
  String pet_personality_labels = '';
  String pet_image_path = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _newItemController = TextEditingController();

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
    List<int> pattern = [3, 4]; // 数量模式
    List<Widget> rowsList = [];

    int itemCount = 0;
    int row = 0;
    while (itemCount < items.length) {
      List<Widget> buttonsList = [];
      int rowButtonsCount = pattern[row % pattern.length];

      for (int j = itemCount;
          j < itemCount + rowButtonsCount && j < items.length;
          j++) {
        buttonsList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: OutlinedButton(
              onPressed: () {
                if (selectedItems.contains(items[j])) {
                  selectedItems.remove(items[j]);
                  pet_personality_labels = selectedItems.join(', ');
                } else {
                  if (selectedItems.length < 5) {
                    selectedItems.add(items[j]);
                    pet_personality_labels = selectedItems.join(', ');
                  }
                }
                setState(() {});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(170, 227, 254, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width / 6,
                      double.infinity), // 设置按钮的最大宽度
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

      itemCount += rowButtonsCount;
      row++;

      rowsList.add(
        Wrap(
          spacing: 8.0, // 按钮之间的水平间距
          runSpacing: 8.0, // 按钮之间的垂直间距
          alignment: WrapAlignment.center,
          children: buttonsList,
        ),
      );
    }

    rowsList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
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
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(170, 227, 254, 1),
                          ),
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
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(170, 227, 254, 1),
                ),
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
      child: Column(
        children: rowsList,
      ),
    );
  }

  List<String> items = [
    '飛盤',
    '接球',
    '散步',
    '捉迷藏',
    '慢跑',
    '衝刺',
    '笨狗',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        pet_image_path = pickedImage.path;
        print(pickedImage.path);
      });
    }
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
                Navigator.pop(context,['','','','','','']);
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
                onPressed: () {
                  Navigator.pop(context, [
                    pet_name,
                    pet_breed,
                    pet_birthday,
                    pet_gender,
                    pet_personality_labels,
                    pet_image_path
                  ]);
                },
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
                  controller: _nameController,
                  onChanged: (value) {
                    setState(() {
                      pet_name = value;
                    });
                  },
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
                  controller: _breedController,
                  onChanged: (value) {
                    setState(() {
                      pet_breed = value;
                    });
                  },
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
                  "寵物生日",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _birthdayController,
                  onChanged: (value) {
                    setState(() {
                      pet_birthday = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none, // 去除边框
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(170, 227, 254, 1)), // 设置底线颜色为蓝色
                    ),
                    hintText: '輸入寵物生日...',
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
                  controller: _genderController,
                  onChanged: (value) {
                    setState(() {
                      pet_gender = value;
                    });
                  },
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
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (_image != null) {
                            return ClipRRect(
                              child: Image.file(
                                _image!,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          } else {
                            return ClipRRect(
                              child: Image.asset(
                                'assets/image/NonePetPicture.png',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          }
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
