import 'package:flutter/material.dart';
import 'EditPetData1.dart';

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
class NextPageButton extends StatelessWidget {
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
                builder: (context) => EditPetDataPage1(title: "Hello world!")
              )
            );
          },
          child: Text(
            '下一步',
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