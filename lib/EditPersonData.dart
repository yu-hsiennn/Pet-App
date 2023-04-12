import 'package:flutter/material.dart';

class EditPersonDataPage extends StatefulWidget {
  const EditPersonDataPage({super.key, required this.title});

  final String title;

  @override
  State<EditPersonDataPage> createState() => _EditPersonDataPageState();
}

class _EditPersonDataPageState extends State<EditPersonDataPage> {
  String? gender;
  Widget buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        '編輯個人資料',
        style: TextStyle(fontSize: 42),
      ),
    );
  }

  Widget buildNameTextField() {
    return const TextField(
      autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
          hintText: "ex:黃大元",
          prefixIcon: Icon(Icons.person)),
    );
  }

  Widget buildIntroTextField() {
    return const TextField(
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: null,
        autofocus: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(width: 3)),
            hintText: "請輸入您的簡介"));
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Padding(
            //上下左右各添加16像素补白
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight),
                buildTitle(),
                const Text('您的名子'),
                buildNameTextField(),
                buildSexRadioButton(),
                const Text('您的簡介'),
                buildIntroTextField(),
                const Text('50字為上限'),
                Center(
                  child: buildNextStepButton(),
                )
              ],
            )));
  }
}
