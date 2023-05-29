import 'package:flutter/material.dart';
import 'package:pet_app/MainPage.dart';

import 'CustomButton.dart';
import 'PetApp.dart';

UserData demoUser1 = UserData(
  name: "peach",
  username: 'demouser',
  password: 'demopw',
  follower: 116,
  pet_count: 2,
  intro: "aasddf",
  photo: "assets/image/peach.jpg",
  petdatas: [demoPet1, demoPet2],
);

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: Text(
                  "註冊",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                autofocus: true,
                cursorColor: Colors.black,
                maxLength: 20,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return '不能為空';
                  }
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
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
                  hintText: "帳號",
                  labelText: '帳號',
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                cursorColor: Colors.black,
                maxLength: 20,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "密碼",
                  labelText: '密碼',
                  helperText: '英文加數字至少6位數',
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
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(maxWidth: 500),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: CustomButton(
                label: '返回',
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
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
                      builder: (context) => MainPage(user: demoUser1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
