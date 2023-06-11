import 'package:flutter/material.dart';
import 'package:pet_app/LogIn.dart';
import 'SignupPage.dart';
import 'PetApp.dart';

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
          scrollbarTheme: ScrollbarThemeData().copyWith(
            thickness: MaterialStateProperty.all(15),
          )),
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(170, 227, 254, 1),
                  Color.fromRGBO(121, 199, 235, 1),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 80),
              Expanded(
                flex: 3,
                child: FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/image/home.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          label: '登入(DEMO)',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          label: '註冊',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
