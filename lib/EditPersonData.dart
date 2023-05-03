import 'package:flutter/material.dart';
import 'package:pet_app/CustomButton.dart';
import 'Profile.dart';
import 'OverviewPage.dart';

class EditPersonDataPage extends StatefulWidget {
  const EditPersonDataPage({super.key, required this.title});

  final String title;

  @override
  State<EditPersonDataPage> createState() => _EditPersonDataPageState();
}

class _EditPersonDataPageState extends State<EditPersonDataPage> {
  String? gender = "unknown";
  String? type = "Dog";

  Widget buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildIntroTextField(String hints) {
    return TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
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
        label: '完成',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OverviewPage()));
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
    return Scaffold(
        // Avoid button OverFlow
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("建立您的資料"),
          titleTextStyle: TextStyle(fontSize: 40),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bottom Overflow!!
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  buildTitle('您的名子'),
                  buildIntroTextField("ex: 黃曉明"),
                  buildSexRadioButton(),
                  buildTitle('飼養的動物種類'),
                  buildPetType(),
                  buildTitle('寵物品種'),
                  buildIntroTextField("柯基"),
                  buildTitle('寵物的名子'),
                  buildIntroTextField("小黑"),
                ],
              ),
            ),
            Container(
              child: Center(
                child: buildNextStepButton(),
              ),
            )
          ],
        ));
  }
}

class UserDetail {
  String name = "Oreo";
  int follower = 0;
  int posts_count = 0;
  String intro = "";
  int pet_count = 1;
  String photo = "123.jpg";
  List<String> posts = ["123.jpg", "456.jpg"];
  List<PetDetail> petdatas = [];

  UserDetail(
      String _name,
      int _follower,
      int _posts_count,
      String _intro,
      int _pet_count,
      String _photo,
      List<String> _posts,
      List<PetDetail> _petdatas) {
    name = _name;
    follower = _follower;
    posts = _posts;
    intro = _intro;
    pet_count = _pet_count;
    photo = _photo;
    posts_count = _posts_count;
    petdatas = _petdatas;
  }
}

class PetDetail {
  String name = "thing";
  String breed = "Gold";
  String gender = "Male";
  int age = 3;
  List<String> personality_lable = ["Smart", "annoying", "cute"];
  String photo = "789.jpg";

  PetDetail(String _name, String _breed, String _gender, int _age,
      List<String> _personality_label, String _photo) {
    name = _name;
    breed = _breed;
    gender = _gender;
    age = _age;
    personality_lable = _personality_label;
    photo = _photo;
  }
}
