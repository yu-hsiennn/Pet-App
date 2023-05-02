import 'package:flutter/material.dart';

class EditPetDataPage1 extends StatefulWidget {
  const EditPetDataPage1({super.key, required this.title});

  final String title;

  @override
  State<EditPetDataPage1> createState() => _EditPetDataPage1State();
}

class _EditPetDataPage1State extends State<EditPetDataPage1> {
  String? gender;
  String? type;
  Widget buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        '編輯寵物資料',
        style: TextStyle(fontSize: 42),
      ),
    );
  }

  Widget buildNameTextField() {
    return const TextField(
      autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
          hintText: "ex:Mini",
          prefixIcon: Icon(Icons.pets)),
    );
  }

  Widget buildNextStepButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 30.0),
      ),
      child: const Text('下一步'),
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
    return DropdownButton(
      isExpanded: true,
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem(
          value: "Dog",
          child: Text(
            "狗",
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
          value: "Dolphine",
          child: Text(
            "海豚",
            style: TextStyle(
                color: type == "Dolphine" ? Colors.black : Colors.grey),
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
          value: "Dinosaur",
          child: Text(
            "其他",
            style: TextStyle(
                color: type == "Dinosaur" ? Colors.black : Colors.grey),
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
      underline: Container(
        height: 1,
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            //上下左右各添加16像素补白
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight),
                buildTitle(),
                const Text('寵物的名子'),
                buildNameTextField(),
                buildSexRadioButton(),
                const Text('飼養的寵物種類'),
                buildPetType(),
                Center(
                  child: buildNextStepButton(),
                )
              ],
            )));
  }
}
