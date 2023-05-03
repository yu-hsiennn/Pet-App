import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'RegisterPage.dart';
import 'OverviewPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Match',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const WelcomePage(title: 'Pet Match Welcome Page'),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                alignment: Alignment.topLeft,
                child: Text('PET MATCH',
                    style: TextStyle(
                      fontSize: 50,
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                alignment: Alignment.topLeft,
                child: Text('Welcome \nPage',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          )),
          Container(
            constraints: BoxConstraints(maxWidth: 500),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    label: '登入',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OverviewPage()));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    label: '注冊',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
