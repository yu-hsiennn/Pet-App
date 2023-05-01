import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'EditPersonData.dart';
import 'EditPetData1.dart';

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
        primarySwatch: Colors.blue,
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
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topCenter,
                  child: Text('PET MATCH',
                      style: TextStyle(
                        fontSize: 50,
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topCenter,
                  child: Text('Welcome Page',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            )),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      label: 'Login',
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RegisterButton(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "註冊",
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                  hintText: "email",
                  labelText: 'email',
                  helperText: 'xxx@gmail.com',
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                  hintText: "password",
                  labelText: 'password',
                  helperText: 'Helper text',
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
        ),
        SizedBox(
          width: 550, // set this
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CancelButton(),
              RegisterConfirmButton(),
            ],
          ),
        )
      ],
    ));
  }
}

class RegisterConfirmButton extends StatelessWidget {
  const RegisterConfirmButton({
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
          ]),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditPersonDataPage(title: "Hello world!")));
          },
          child: Text(
            '確認',
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

class CancelButton extends StatelessWidget {
  const CancelButton({
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
              Color.fromRGBO(143, 201, 255, 1),
              Color.fromRGBO(234, 255, 143, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 33, 96, 243).withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ]),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            '取消',
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

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 60,
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
            ]),
        child: Center(
          child: Text(
            'Create Account',
            textAlign: TextAlign.center,
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

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (details) {},
      child: Container(
        margin: EdgeInsets.all(5), // padding edge
        height: 60,
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
            ]),
        child: Center(
          child: Text(
            'Login',
            textAlign: TextAlign.center,
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

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 60,
    this.width,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTappedDown = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTappedDown = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isTappedDown = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isTappedDown
                  ? [
                      Color.fromRGBO(159, 89, 99, 1),
                      Color.fromRGBO(168, 124, 94, 1),
                    ]
                  : [
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
            ]),
        padding: EdgeInsets.all(5),
        height: widget.height,
        width: widget.width,
        child: Center(
          child: Text(
            widget.label,
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
