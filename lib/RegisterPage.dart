import 'package:flutter/material.dart';
import 'package:pet_app/PetApp.dart';
import 'CustomButton.dart';
import 'EditProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool hidePassword = true;
  final TextEditingController _textControllerUsername = TextEditingController();
  final TextEditingController _textControllerP1 = TextEditingController();
  final TextEditingController _textControllerP2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodePw1 = FocusNode();
  final FocusNode _focusNodePw2 = FocusNode();

  void saveLocal(String username, String password) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('username', username);
    await storage.setString('password', password);
  }

  void retrieveLocal() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    final String? a = storage.getString('username');
    if (a != null) {
      setState(() {
        _textControllerUsername.text = a;
      });
    } else {
      setState(() {
        _textControllerUsername.text = '';
      });
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      saveLocal(_textControllerUsername.text, _textControllerP1.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePage(
                  user: UserData(
                      username: _textControllerUsername.text,
                      password: _textControllerP1.text))));
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
            body: Column(
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
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    autofocus: true,
                    controller: _textControllerUsername,
                    cursorColor: Colors.black,
                    maxLength: 20,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return '不能為空';
                      }
                    },
                    onEditingComplete: () {
                      if (_formKey.currentState?.validate() == true) {
                        FocusScope.of(context).requestFocus(_focusNodePw1);
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(96, 175, 245, 1)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromRGBO(96, 175, 245, 1)),
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
                      hintText: "用戶名",
                      labelText: '用戶名',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    focusNode: _focusNodePw1,
                    controller: _textControllerP1,
                    cursorColor: Colors.black,
                    maxLength: 20,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_focusNodePw2);
                    },
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(96, 175, 245, 1)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromRGBO(96, 175, 245, 1)),
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
                      hintText: "密碼",
                      labelText: '密碼',
                      helperText: '請設定英文加數字至少6位數',
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
                    focusNode: _focusNodePw2,
                    controller: _textControllerP2,
                    cursorColor: Colors.black,
                    maxLength: 20,
                    obscureText: hidePassword,
                    validator: (value) {
                      if (_textControllerP1.text != value) {
                        return '密碼必須相符!';
                      }
                    },
                    onEditingComplete: _submit,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(96, 175, 245, 1)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromRGBO(96, 175, 245, 1)),
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
                      hintText: "重複輸入密碼",
                      labelText: '重複輸入密碼',
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
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 93),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          label: '確認',
                          onPressed: _submit,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          label: '返回',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
