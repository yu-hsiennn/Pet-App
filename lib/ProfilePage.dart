import 'package:flutter/material.dart';
import 'CustomWidget.dart';
import 'EditPersonDataPage.dart';
import 'CustomButton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.person});
  final UserDetail person;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustomWidget cw = new CustomWidget();
  String gender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              profile_info(widget.person.photo, widget.person.posts_count,
                  widget.person.follower, true),
              Text_title("飼主簡介"),
              Text_info(
                  "tttttttttttttttteeeeeeeeeeeeeeeeeeeesssssssssssssssssttttttttttttttt"),
              Text_title("寵物資料"),
              Pets_photo(widget.person.petdatas),
              Text_title("寵物相簿"),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile_info(
      String file_name, int posts_count, int followers, bool is_user) {
    if (is_user) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: cw.Profile_photo(35, file_name: file_name),
              flex: 1,
            ),
            Spacer(),
            Flexible(
              child: cw.Text_count("Follower", followers),
              flex: 1,
            ),
            Spacer(),
            Flexible(
              child: cw.Text_count("Posts", posts_count),
              flex: 1,
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: cw.Profile_photo(25, file_name: file_name),
            flex: 1,
            fit: FlexFit.loose,
          ),
          Spacer(),
          Flexible(
            child: Column(
              children: [
                cw.Text_count("Follower", followers),
                CustomButton(
                  label: 'Follow',
                  onPressed: () {},
                  height: 20,
                  width: 100,
                ),
              ],
            ),
            flex: 1,
            fit: FlexFit.loose,
          ),
          Spacer(),
          Flexible(
            child: Column(
              children: [
                cw.Text_count("Posts", posts_count),
                CustomButton(
                  label: 'Chats',
                  onPressed: () {},
                  height: 20,
                  width: 100,
                ),
              ],
            ),
            flex: 1,
            fit: FlexFit.loose,
          ),
        ],
      ),
    );
  }

  Widget Text_title(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Text_info(String info) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
      child: Text(
        info,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget Pets_photo(List<PetDetail> pets_list) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Row(
        children: pets_list
            .map((pet) => cw.Profile_photo(35, file_name: pet.photo))
            .toList(),
      ),
    );
  }
}
