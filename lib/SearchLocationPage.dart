import 'package:flutter/material.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPage();
}

class _SearchLocationPage extends State<SearchLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
      onPressed: () {
        Navigator.pop(context, '返回值');
      },
      child: Text('返回'),
    ));
  }
}
