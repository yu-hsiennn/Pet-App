import 'package:flutter/material.dart';
import 'Profile.dart';

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

  // Widget buildNameTextField() {
  //   return const TextField(
  //     autofocus: true,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
  //         hintText: "ex:黃大元",
  //         prefixIcon: Icon(Icons.person)),
  //   );
  // }

  Widget buildIntroTextField(String hints) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: hints,
      )
    );
  }

  Widget buildNextStepButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 30.0),
      ),
      child: NextPageButton(),
    );
  }

  Widget buildSexRadioButton() {
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile(
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
          borderSide: BorderSide(width: 3),
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
            style: TextStyle(color: type == "Dog" ? Colors.black : Colors.grey),
          ),
        ),
        DropdownMenuItem(
          value: "Cat",
          child: Text(
            "貓",
            style: TextStyle(color: type == "Cat" ? Colors.black : Colors.grey),
          ),
        ),
        DropdownMenuItem(
          value: "Dolphin",
          child: Text(
            "海豚",
            style: TextStyle(
                color: type == "Dolphin" ? Colors.black : Colors.grey),
          ),
        ),
        DropdownMenuItem(
          value: "Dinosaur",
          child: Text(
            "恐龍",
            style: TextStyle(
                color: type == "Dinosaur" ? Colors.black : Colors.grey),
          ),
        ),
        DropdownMenuItem(
          value: "Others",
          child: Text(
            "其他",
            style: TextStyle(
                color: type == "Others" ? Colors.black : Colors.grey),
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
      appBar: AppBar(
        title: const Text("建立您的資料"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bottom Overflow!!
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
              flex: 3,
            ),
            Flexible(child: Center(
              child: buildNextStepButton(),
              ),
              flex: 2,
            )
          ],
        )
      )
    );
  }
}
class NextPageButton extends StatelessWidget {
  static PetDetail pt1 = new PetDetail("Luchi", "Gold", "Male", 3, ["123", "456", "789"], "assets/image/dog1.jpg");
  static PetDetail pt2 = new PetDetail("Lushi", "Gold", "Female", 2, ["321", "987"], "assets/image/dog2.jpeg");
  static UserDetail p1 = new UserDetail("peach", 116, 0, "I'm priness", 2, "assets/image/peach.jpg", ["assets/image/dog2.jpeg", "assets/image/dog3.jpg"], [pt1, pt2]);

  const NextPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        height: 60,
        width: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 143, 158, 1),
              Color.fromRGBO(255, 188, 143, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ]
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(person: p1)
                )
              );
            },
            child: Text(
              '完成',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
    );
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

  UserDetail(String _name, int _follower, int _posts_count, String _intro, int _pet_count, String _photo, List<String> _posts, List<PetDetail> _petdatas) {
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

  PetDetail(String _name, String _breed, String _gender, int _age, List<String> _personality_label, String _photo) {
    name = _name;
    breed = _breed;
    gender = _gender;
    age = _age;
    personality_lable = _personality_label;
    photo = _photo;
  }
}