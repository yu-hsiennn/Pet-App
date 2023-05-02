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
              fontSize: 16,
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
    return CircleAvatar(
      radius: framesize.toDouble(),
      backgroundImage: AssetImage(
        file_name,
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