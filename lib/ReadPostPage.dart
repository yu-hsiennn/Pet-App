import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_app/PetApp.dart';
import 'package:http/http.dart' as http;
class ReadPostPage extends StatefulWidget {
  const ReadPostPage({super.key, required this.post, required this.ownername, required this.ownerphoto});
  final Posts post;
  final String ownername;
  final String ownerphoto;
  @override
  State<ReadPostPage> createState() => _ReadPostPageState();
}

class _ReadPostPageState extends State<ReadPostPage> {
  bool isLiked = false;

  Widget buildNameTextField() {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.ownerphoto),
      ),
      title: Text(
        widget.ownername,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildPicture(String picture) {
    return Image.network(
      picture,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
    );
  }

  Widget buildLikeField(int likeNum) {
    return Row(
      children: [
        SizedBox(width: 12),
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
        ),
        Text(
          "$likeNum個喜歡",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget buildTextField(String text) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildDateField(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        date,
        style: TextStyle(
          color: Colors.grey[400], // 使用淡化的颜色值
        ),
      ),
    );
  }

  Widget buildLabelField(List<String> label) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        for (var item in label)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(170, 227, 254, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildMessageField(List<Comment> messages) {
    return Column(
      children: [
        for (int i = 0; i < messages.length; i++)
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${PetApp.Server_Url}/user/${messages[i].owner_id}/profile_picture"),
                  radius: 15.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(messages[i].content),
              ),
            ],
          ),
      ],
    );
  }
  Future<void> createReply(
        int postId, int postAttraction, String postContent) async {
      final response = await http.post(
        Uri.parse(PetApp.Server_Url + '/posts'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ' + PetApp.CurrentUser.authorization,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "owner_id": PetApp.CurrentUser.email,
          "response_to":postId,
          "attraction": postAttraction,
          "content": postContent,
          "label": "",
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        print(responseData);
      } else {
        print(
            'Request failed with status: ${json.decode(response.body)['detail']}.');
      }
    }
  Widget buildInputMessageField() {
    TextEditingController textController = TextEditingController();
    print(widget.post.owner_id);
    print(widget.post.post_picture);
    print(widget.post.Likes);
    print(widget.post.content);
    print(widget.post.Comments);
    print(widget.post.response_to);
    print(widget.post.id);
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(96, 175, 245, 1),
                  width: 1,
                ),

                borderRadius: BorderRadius.circular(20), // 设置圆角半径
              ),
              child: TextField(
                 controller: textController,
                autofocus: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: "新增留言...",
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          iconSize: 40,
          onPressed: () {
             String messagetext = textController.text;
                createReply(widget.post.id, 1, messagetext);
          },
          icon: Image.asset(
            'assets/image/post_message_submit.png',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildNameTextField(),
            SizedBox(height: 20),
            buildPicture(widget.post.post_picture),
            buildLikeField(widget.post.Likes.length),
            buildTextField(widget.post.content),
            buildDateField('5月20號 16:34'),
            buildLabelField([]),
            Divider(
              // 添加蓝色线
              color: Color.fromRGBO(170, 227, 254, 1),
              thickness: 1,
            ),
            // buildMessageField(widget.post.Comments),
            buildInputMessageField()
          ]),
    ))));
  }
}
