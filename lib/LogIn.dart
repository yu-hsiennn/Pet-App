import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_app/MainPage.dart';
import 'PetApp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  bool hidePassword = true;
  String _email = "", _password = "";
  String loginUrl =  PetApp.Server_Url + '/user/login';
  String GetUserUrl = PetApp.Server_Url + '/user/';
  // String AttractionUrl = PetApp.Server_Url + '/attraction';

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': _email,
        'password': _password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      PetApp.CurrentUser.authorization = responseData['access token'];
      print(responseData);
      GetUser();
      // GetAttraction();
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> GetUser() async {
    List<Posts> _post = [];
    final response = await http.get(Uri.parse(GetUserUrl + _email), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var post in responseData['posts']) {
        _post.add(
          Posts(
            owner_id: post["owner_id"], 
            content: post["content"], 
            id: post["id"], 
            timestamp: post["timestamp"]
          )
        );
      }
      
      PetApp.CurrentUser.email = responseData['email'];
      PetApp.CurrentUser.name = responseData['name'];
      PetApp.CurrentUser.intro = responseData['intro'];
      PetApp.CurrentUser.locations = responseData['location'];
      PetApp.CurrentUser.password = _password;
      PetApp.CurrentUser.posts = _post;
      PetApp.CurrentUser.profile_picture = "${PetApp.Server_Url}/user/$_email/profile_picture";
      print(responseData);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  // Future<void> GetAttraction() async {
  //   List<Attraction> _attractions = [];
  //   final response = await http.get(Uri.parse(AttractionUrl), headers: {
  //     'accept': 'application/json',
  //   });

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     for (var attraction in responseData) {
  //       List<Posts> _post = [];
  //       for (var post in attraction['posts']) {
  //         _post.add(
  //           Posts(
  //             owner_id: post["owner_id"], 
  //             content: post["content"], 
  //             id: post["id"], 
  //             timestamp: post["timestamp"],
  //             response_to: post['response_to']
  //           )
  //         );
  //       }
  //       _attractions.add(
  //         Attraction(
  //           name: attraction['name'],
  //           address: attraction['location'],
  //           lat: attraction['lat'],
  //           lon: attraction['lon'],
  //           posts: _post,
  //           id: attraction['id']
  //         )
  //       );
  //     }
      
  //     PetApp.Attractions = _attractions;
  //     print(responseData);
  //   } else {
  //     print(
  //         'Request failed with status: ${json.decode(response.body)['detail']}.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(30.0),
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
                  "登入",
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
                onChanged: (value) {
                  _email = value;
                },
                autofocus: true,
                cursorColor: Color.fromRGBO(96, 175, 245, 1),
                maxLength: 20,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return '不能為空';
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
                onChanged: (value) {
                  _password = value;
                },
                cursorColor: Color.fromRGBO(96, 175, 245, 1),
                maxLength: 20,
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
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 93),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FutureBuilder<void>(
                    future: loginUser(),
                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomButton(
                                label: '確認',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                    ),
                                  );
                                },
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
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
