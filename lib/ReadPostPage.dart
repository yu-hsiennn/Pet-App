import 'package:flutter/material.dart';
import 'package:pet_app/PetApp.dart';

class ReadPostPage extends StatefulWidget {
  const ReadPostPage({super.key, required this.post});
  final Post post;
  @override
  State<ReadPostPage> createState() => _ReadPostPageState();
}

class _ReadPostPageState extends State<ReadPostPage> {
  bool isLiked = false;

  Widget buildNameTextField(String name, String icon) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      dense: true,
      leading: CircleAvatar(
        backgroundImage: AssetImage(icon),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold, // 设置文本加粗
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
                  backgroundImage: NetworkImage(messages[i].user.photo),
                  radius: 15.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(messages[i].comment_info),
              ),
            ],
          ),
      ],
    );
  }

  Widget buildInputMessageField(String usericon) {
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
            // 这里可以写提交操作的代码
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
            buildNameTextField(
                widget.post.poster.name, widget.post.poster.photo),
            SizedBox(height: 20),
            buildPicture(widget.post.pictures),
            buildLikeField(widget.post.like_count),
            buildTextField(widget.post.post_info),
            buildDateField('5月20號 16:34'),
            buildLabelField(widget.post.label),
            Divider(
              // 添加蓝色线
              color: Color.fromRGBO(170, 227, 254, 1),
              thickness: 1,
            ),
            buildMessageField(widget.post.comments),
            buildInputMessageField(widget.post.poster.photo)
          ]),
    ))));
  }
}
