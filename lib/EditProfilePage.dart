import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_app/CustomButton.dart';
import 'package:pet_app/PetApp.dart';
import 'MainPage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final UserData user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? gender = "unknown";
  String? type = "Dog";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _introController = TextEditingController();

  Widget buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildIntroTextField(String hints, TextEditingController? controller) {
    return TextField(
        cursorColor: Color.fromRGBO(96, 175, 245, 1),
        controller: controller,
        decoration: InputDecoration(
          focusColor: Color.fromRGBO(96, 175, 245, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintText: hints,
        ));
  }

  Widget buildNextStepButton() {
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      margin: EdgeInsets.only(bottom: 10),
      child: CustomButton(
        label: '下一步',
        onPressed: () {
          widget.user.name = _nameController.text;
          widget.user.intro = _introController.text;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditUploadPhoto(user: widget.user)));
        },
      ),
    );
  }

  Widget buildSexRadioButton() {
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile(
            activeColor: Colors.black,
            title: const Text("男性"),
            value: "male",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile(
            activeColor: Colors.black,
            title: const Text("女性"),
            value: "female",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile(
            activeColor: Colors.black,
            title: const Text("不透漏"),
            value: "unknown",
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value.toString();
              });
            },
          ),
        )
      ],
    );
  }

  Widget buildPetType() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
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
                      )
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
                    buildIntroTextField("台南市 東區", null),
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
  const EditUploadPhoto({super.key, required this.user});
  final UserData user;

  @override
  State<EditUploadPhoto> createState() => _EditUploadPhotoState();
}

class _EditUploadPhotoState extends State<EditUploadPhoto> {
  File? _imageFile ;
  final String _empty = "assets/image/_upload.png";
  
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
    widget.user.photo = "assets/image/peach.jpg";
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      margin: EdgeInsets.only(bottom: 10),
      child: CustomButton(
        label: '完成',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(user: widget.user)));
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
                    )
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 300,
                      height: 300,
                      child: _imageFile != null ? 
                      Image.file(
                        _imageFile!,
                        width: 300,
                        height: 300,
                      ) : Image.asset(
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
        )
      ),
    );
  }
}

// class _UploadPostPicturePageState extends State<UploadPostPicturePage> {
//   File? _imageFile;

//   void _pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedImage != null) {
//         _imageFile = File(pickedImage.path);
//       } else {
//         _imageFile = null;
//       }
//     });
//   }

//   void _clearImage() {
//     setState(() {
//       _imageFile = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Picker Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_imageFile != null)
//               Image.file(
//                 _imageFile!,
//                 width: 200,
//                 height: 200,
//               )
//             else
//               const Text('No image selected'),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('Pick Image'),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _clearImage,
//                   child: const Text('Clear Image'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }