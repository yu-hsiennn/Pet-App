import 'package:flutter/material.dart';

class CustomWidget {
  CustomWidget();
  
  // follower or following or posts widget 
  Widget Text_count(String title, int counts) {
    return Container(
      child: Column(
        children: [
          Text(title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(counts.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // profile photo
  Widget Profile_photo(int framesize, {String file_name="assets/image/empty.jpg"}) {
    String _file_name = file_name.isEmpty ? "assets/image/empty.jpg" : file_name;
    return CircleAvatar(
      radius: framesize.toDouble(),
      backgroundImage: AssetImage(
        _file_name,
      ),
    );
  }

  // Label
  Widget Labels(String label) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0)
        ),
      ),
      child: Text(label),
    );
  }

}