import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'EditPersonData.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                "註冊",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                initialValue: '',
                maxLength: 20,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "電郵",
                  labelText: '電郵',
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                cursorColor: Theme.of(context).hintColor,
                initialValue: '',
                maxLength: 20,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "密碼",
                  labelText: '密碼',
                  helperText: '請設定英文加數字至少6位數',
                  // errorText: 'Error message',
                  // suffixIcon: Icon(
                  //   Icons.error,
                  // ),
                  suffixIcon: IconButton(
                    icon: hidePassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                cursorColor: Theme.of(context).hintColor,
                initialValue: '',
                maxLength: 20,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "重複輸入密碼",
                  labelText: '重複輸入密碼',
                  // helperText: '請設定英文加數字至少6位數',
                  // errorText: 'Error message',
                  // suffixIcon: Icon(
                  //   Icons.error,
                  // ),
                  suffixIcon: IconButton(
                    icon: hidePassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        )),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                  label: '取消',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  regularColors: [
                    Color.fromRGBO(143, 201, 255, 1),
                    Color.fromRGBO(234, 255, 143, 1),
                  ],
                  tappedDownColors: [
                    Color.fromRGBO(105, 148, 188, 1),
                    Color.fromRGBO(164, 178, 101, 1),
                  ],
                  height: 60,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomButton(
                  label: '確認',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditPersonDataPage(title: "Hello world!")));
                  },
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
