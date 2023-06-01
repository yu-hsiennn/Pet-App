import 'dart:io';
import 'location_service.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/CustomButton.dart';
import 'package:pet_app/PetApp.dart';
import 'MainPage.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {super.key, required this.user_email, required this.user_password});

  final String user_email, user_password;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? gender = "unknown";
  String? type = "Dog";
  String nickname = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Widget buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildIntroTextField(String hints, TextEditingController? controller) {
    return TextField(
        cursorColor: Color.fromRGBO(96, 175, 245, 1),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(96, 175, 245, 1)),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromRGBO(96, 175, 245, 1)),
            borderRadius: BorderRadius.circular(30.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: OutlineInputBorder(),
          hintText: hints,
        ));
  }

  Widget buildNextStepButton() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 93),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: CustomButton(
              label: '下一步',
              onPressed: () {
                nickname = _nameController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUploadPhoto(
                              user_email: widget.user_email,
                              user_password: widget.user_password,
                              location: _locationController.text,
                              nickname: _nameController.text,
                            )));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSexRadioButton() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Color.fromRGBO(96, 175, 245, 1),
            ),
            child: RadioListTile(
              activeColor: Color.fromRGBO(96, 175, 245, 1),
              title: const Text(
                "男性",
                style: TextStyle(color: Color.fromRGBO(96, 175, 245, 1)),
              ),
              value: "male",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
          ),
        ),
        Flexible(
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Color.fromRGBO(96, 175, 245, 1),
            ),
            child: RadioListTile(
              activeColor: Color.fromRGBO(96, 175, 245, 1),
              title: const Text(
                "女性",
                style: TextStyle(color: Color.fromRGBO(96, 175, 245, 1)),
              ),
              value: "female",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
          ),
        ),
        Flexible(
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor: Color.fromRGBO(96, 175, 245, 1),
            ),
            child: RadioListTile(
              activeColor: Color.fromRGBO(96, 175, 245, 1),
              title: const Text(
                "不透漏",
                style: TextStyle(color: Color.fromRGBO(96, 175, 245, 1)),
              ),
              value: "unknown",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildPetType() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(96, 175, 245, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(96, 175, 245, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(96, 175, 245, 1),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      isExpanded: true,
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem(
          value: "Dog",
          child: Text(
            "狗",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
          ),
        ),
        DropdownMenuItem(
          value: "Cat",
          child: Text(
            "貓",
            style: TextStyle(color: Colors.black),
          ),
        ),
        DropdownMenuItem(
          value: "Dolphin",
          child: Text(
            "海豚",
            style: TextStyle(color: Colors.black),
          ),
        ),
        DropdownMenuItem(
          value: "Dinosaur",
          child: Text(
            "恐龍",
            style: TextStyle(color: Colors.black),
          ),
        ),
        DropdownMenuItem(
          value: "Others",
          child: Text(
            "其他",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      hint: const Text("動物種類"), // 當沒有初始值時顯示
      onChanged: (selectValue) {
        //選中後的回撥
        setState(() {
          type = selectValue;
        });
      },
      value: type, // 設定初始值，要與列表中的value是相同的
      iconSize: 30, //設定三角標icon的大小
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color.fromRGBO(96, 175, 245, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // Avoid button OverFlow
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 30,
                          Icons.arrow_back,
                          color: Color.fromRGBO(96, 175, 245, 1),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 55,
                      child: Text(
                        "建立您的資料",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    buildTitle('您的暱稱'),
                    buildIntroTextField("黃曉明", _nameController),
                    buildSexRadioButton(),
                    buildTitle('飼養的動物種類'),
                    buildPetType(),
                    buildTitle('經常散步區域'),
                    buildIntroTextField("台南市 東區", _locationController),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: buildNextStepButton(),
                ),
              )
            ],
          )),
    );
  }
}

class EditUploadPhoto extends StatefulWidget {
  const EditUploadPhoto(
      {super.key,
      required this.user_email,
      required this.user_password,
      required this.nickname,
      required this.location});
  final String user_email, user_password, location, nickname;

  @override
  State<EditUploadPhoto> createState() => _EditUploadPhotoState();
}

class _EditUploadPhotoState extends State<EditUploadPhoto> {
  File? _imageFile;
  final String _empty = "assets/image/_upload.png";
  String profile_picture = "";

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

  Widget buildNextStepButton() {
    String signupUrl = 'http://10.0.2.2:8000/user/signup';
    String loginUrl = 'http://10.0.2.2:8000/user/login';

    Future<void> signupUser() async {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': widget.user_email,
          'name': widget.nickname,
          'intro': "",
          'birthday': "2023/6/1",
          'password': widget.user_password
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

    Future<void> loginUser() async {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': widget.user_email,
          'password': widget.user_password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

    // widget.user.photo = "assets/image/peach.jpg";
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      margin: EdgeInsets.only(bottom: 10),
      child: CustomButton(
        label: '完成',
        onPressed: () {
          signupUser();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // Avoid button OverFlow
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 30,
                          Icons.arrow_back,
                          color: Color.fromRGBO(96, 175, 245, 1),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 55,
                      child: Text(
                        "建立您的資料",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                      child: Text(
                        "上傳頭像",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 300,
                        height: 300,
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                width: 300,
                                height: 300,
                              )
                            : Image.asset(
                                _empty,
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: buildNextStepButton(),
                ),
              )
            ],
          )),
    );
  }
}
