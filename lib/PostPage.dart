import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'PetApp.dart';
import 'SearchLocationPage.dart';
import 'MainPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _newItemController = TextEditingController();
  String location = "新增地點";
  int locationid = -1;
  String imagePath = 'assets/image/NonePicture.png';
  File? _imageFile;
  int post_id = 0;

  void chooseImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        imagePath = pickedImage.path;
        print(pickedImage.path);
      } else {
        _imageFile = null;
      }
    });
  }

  Widget buildPictureField() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: chooseImage,
            child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  width: 300,
                  height: 300,
                )
              : Image.asset(
                  imagePath,
                  width: 200,
                  height: 200,
                ),
          ),
        );
      },
    );
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
                } else {
                  if (selectedItems.length < 5) {
                    selectedItems.add(items[j]);
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
  String inputText = '';
  Widget buildInputField() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            inputText = value;
          });
        },
        decoration: InputDecoration(
          hintText: '輸入說明文字...',
          border: InputBorder.none,
        ),
        maxLines: null,
        textInputAction: TextInputAction.newline,
      ),
    );
  }

  Widget buildLocationButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: OutlinedButton(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    location,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_forward,
                    color: Color.fromRGBO(170, 227, 254, 1)),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Color.fromRGBO(170, 227, 254, 1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchLocationPage()),
            ).then((value) {
              locationid = value[1];
              setState(() {
                location = value[0];
              });
              // Do something with returned data
            });
          },
        ),
      ),
    );
  }

  Widget buildTextField(String Word) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$Word',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Future<void> createPost(
      String ownerid, int attractionid, String content) async {
    final response = await http.post(
      Uri.parse(PetApp.Server_Url + '/posts'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${PetApp.CurrentUser.authorization}",
      },
      body: jsonEncode({
        'owner_id': ownerid,
        'response_to': 0,
        'attraction': attractionid,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      post_id = responseData['id'];
      print(responseData);
    } else {
      print('Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> PostPicture() async {
    var upUrl = Uri.parse("${PetApp.Server_Url}/posts/$post_id/file?fileending=jpg");
    print(upUrl);
    var request = http.MultipartRequest('POST', upUrl);
    request.headers.addAll({
      'accept': 'application/json',
      'Authorization': "Bearer ${PetApp.CurrentUser.authorization}",
    });
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Profile picture uploaded successfully');
    } else {
      print('Failed to upload profile picture. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            '新貼文',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(96, 175, 245, 1),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(builder: (context) => new MainPage()),
                (route) => route == null,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                createPost(PetApp.CurrentUser.email, locationid, inputText).then((_) {
                  return PostPicture();
                });

                Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(builder: (context) => new MainPage()),
                  (route) => route == null,
                );
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                buildPictureField(),
                buildLocationButton(),
                buildTextField('新增貼文標籤'),
                buildSelectedField(),
                buildLabelField(items),
                buildTextField('輸入貼文說明'),
                buildInputField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
