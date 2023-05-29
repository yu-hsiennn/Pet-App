import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'RegisterPage.dart';
import 'MainPage.dart';

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
              Image.asset(
                "assets/image/Home.jpg",
                height: double.infinity,
                // width: double.infinity,
              ),
              Positioned(
                top: 700,
                bottom: 20,
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 410),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              label: '登入(DEMO)',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage(user: demoUser1)));
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              label: '註冊',
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
              )
            ],
          ),
        );
  }
}
// Column(
//           Container(
//             constraints: BoxConstraints(maxWidth: 500),
//             margin: EdgeInsets.only(bottom: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: CustomButton(
//                     label: '登入(DEMO)',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MainPage(user: demoUser1)));
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: CustomButton(
//                     label: '註冊',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RegisterPage()));
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),