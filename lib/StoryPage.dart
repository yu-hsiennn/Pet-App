import 'package:flutter/material.dart';
import 'package:pet_app/ReadPostPage.dart';
import 'PetApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoryPage extends StatefulWidget {
  const StoryPage(
      {super.key, required this.Post_list, required this.Post_Index});
  final List<Posts> Post_list;
  final int Post_Index;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ScrollController _scrollController;
  double _scrollOffset = 0;
  List<bool> isLiked = [true, false, false];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollOffset = MediaQuery.of(context).size.height;
    _scrollController = ScrollController(
        initialScrollOffset: _scrollOffset * widget.Post_Index * 6 / 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.Post_list.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text(widget.Post_list[index].pictures);
          return buildPost(widget.Post_list[index], index);
        },
      ),
    );
  }

  Widget buildPost(Posts Post, int post_index) {
    bool _isVisible = false;
    String ownername = '';
    String ownerphoto = '';
    Future<void> getOwnername(String ownerId) async {
      String GetUserUrl = PetApp.Server_Url + '/user/' + ownerId;
      final response = await http.get(Uri.parse(GetUserUrl), headers: {
        'accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ownername = responseData['name'];
        print(responseData);
      } else {
        print(
            'Request failed with status: ${json.decode(response.body)['detail']}.');
      }
    }

    Future<void> getOwnerPhoto(String ownerId) async {
      String GetUserUrl = PetApp.Server_Url + '/user/' + ownerId+'/profile_picture';
      final response = await http.get(Uri.parse(GetUserUrl), headers: {
        'accept': 'application/json',
      });

      if (response.statusCode == 200) {
        ownerphoto = "${PetApp.Server_Url}/user/$ownerId/profile_picture";
      } else {
        print(
            'Request failed with status: ${json.decode(response.body)['detail']}.');
      }
    }

    Widget buildNameTextField(String ownerId) {
      getOwnername(ownerId);
      getOwnerPhoto(ownerId);
      return Expanded(
        flex: 1, // 20%
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 3),
          dense: true,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(ownerphoto),
          ),
          title: Text(
            ownername,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }


    Widget buildPicture(String picture) {
      return Expanded(
        flex: 6, // 20%
        child: Image.network(
          picture,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    Widget buildLikeField(int likeNum, int index) {
      return Row(
        children: [
          SizedBox(width: 12),
          IconButton(
            icon: Icon(
              isLiked[index] ? Icons.favorite : Icons.favorite_border,
              color: isLiked[index] ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                isLiked[index] = !isLiked[index];
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
      return Expanded(
        flex: 2, // 20%
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    Widget buildDateField(String date) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          date,
          style: TextStyle(
            color: Colors.grey[400],
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
      return Row(
        children: [
          SizedBox(
            width: 12,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReadPostPage(
                          post: Post,
                        )),
              );
            },
            child: Text(
              '查看全部${messages.length}則留言',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      );
    }

    Widget buildInputMessageField() {
      return Expanded(
        flex: 1, // 20%
        child: Row(
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

                    borderRadius: BorderRadius.circular(20),
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
        ),
      );
    }

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 6 / 7,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNameTextField(Post.owner_id),
              SizedBox(height: 20),
              buildPicture(Post.post_picture),
              buildLikeField(Post.Likes.length, post_index),
              buildTextField(Post.content),
              buildDateField('5月20號 16:34'),
              buildLabelField([]),
              buildMessageField(Post.Comments),
              buildInputMessageField()
            ]),
      ),
    );
  }
}
