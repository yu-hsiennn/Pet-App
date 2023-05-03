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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '注冊',
          ),
          titleTextStyle: TextStyle(
            fontSize: 40,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    initialValue: '',
                    maxLength: 20,
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
                      hintText: "電郵",
                      labelText: '電郵',
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
                    initialValue: '',
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
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    initialValue: '',
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
              constraints: BoxConstraints(maxWidth: 250),
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
