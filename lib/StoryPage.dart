import 'package:flutter/material.dart';
import 'package:pet_app/MainPage.dart';
import 'package:pet_app/ProfilePage.dart';
import 'package:pet_app/ReadPostPage.dart';
import 'ChatOverviewPage.dart';
import 'HomePage.dart';
import 'PetApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PostPage.dart';
import 'ReadPostPage.dart';
import 'dart:core';
import 'package:intl/intl.dart';

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
  String GetUserUrl = PetApp.Server_Url + '/user/';
  double _scrollOffset = 0;
  List<bool> isLiked = [true, false, false, false, false, false, false, false, false, false, false,true, false, false, false, false, false, false, false, false, false, false];
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



void _onItemTapped(int index) {

  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 0)),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 1)),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MainPage(current_index: 2)),
      );
      break;
    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 3)),
      );
      break;
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(96, 175, 245, 1),
      title: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              "PETSHARE",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.black,
              ),
            ),
            Text(
              "PETSHARE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
    ),
    body: ListView.builder(
      controller: _scrollController,
      itemCount: widget.Post_list.length,
      itemBuilder: (BuildContext context, int index) {
        //return Text(widget.Post_list[index].pictures);
        return buildPost(widget.Post_list[index], index);
      },
    ),
    bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: Colors.yellow,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedIconTheme: IconThemeData(size: 20),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.blue,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.upload_outlined,
            color: Colors.blue,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_outlined,
            color: Colors.blue,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(color: Colors.blue, Icons.person_outlined),
          label: 'Profile',
        ),
      ],
    ),
  );
}

  Widget buildPost(Posts Post, int post_index) {
    bool _isVisible = false;
    User user = new User(email: "", name: "", intro: "", locations: "", password: "");
    List<Comment> comments = [];

    Future<void> GetUser(String ownerId) async {
      List<Posts> _post = [];
      List<Pet> _pet = [];
      final response = await http.get(Uri.parse(GetUserUrl + ownerId), headers: {
        'accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        for (var post in responseData['posts']) {
          if (post['response_to'] == 0) {
            var temp1 = post['files'][0]['file_path'].split("/");
            var temp2 = temp1[1].split(".");
            _post.add(Posts(
                owner_id: post["owner_id"],
                content: post["content"],
                id: post["id"],
                label: post['label'],
                timestamp: post["timestamp"],
                response_to: post['response_to'],
                post_picture: "${PetApp.Server_Url}/file/${temp2[0]}"));
          }
        }
        for (var pets in responseData['pets']) {
          var temp1 = pets['files'][0]['file_path'].split("/");
          var temp2 = temp1[1].split(".");
          _pet.add(Pet(
            owner: pets['owner'],
            birthday: pets['birthday'],
            breed: pets['breed'],
            gender: pets['gender'],
            id: pets['id'],
            name: pets['name'],
            personality_labels: pets['personality_labels'],
            picture: "${PetApp.Server_Url}/file/${temp2[0]}"
          ));
        }

        user.email = responseData['email'];
        user.name = responseData['name'];
        user.intro = responseData['intro'];
        user.posts = _post;
        user.pets = _pet;
        user.profile_picture =
            "${PetApp.Server_Url}/user/${responseData['email']}/profile_picture";
      } else {
        print(
            'Request failed with status: ${json.decode(response.body)['detail']}.');
      }
    }

    Widget buildNameTextField(String ownerId) {
    return FutureBuilder(
      future: GetUser(ownerId),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching data
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error case
          return Text('Error: ${snapshot.error}');
        } else {
          // Data has been fetched, display the owner's name and photo
          return Expanded(
  flex: 1,
  child: GestureDetector(
    onTap: () {
      Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(Is_Me: false, user: user)),
              );
    },
    child: ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profile_picture),
      ),
      title: Text(
        user.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
);
        }
      },
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

    Widget buildLabelField(List<String> label, String txt) {
      print(label);
      print(txt);
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
    Future<void> GetComment() async {
    List<Comment> _comment = [];
    final response = await http.get(
        Uri.parse(PetApp.Server_Url + '/posts/{post_id}/replies?postid=${Post.id}'),
        headers: {
          'accept': 'application/json',
        });

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      for (var message in responseData) {
        _comment.add(Comment(
            owner_id: message["owner_id"],
            content: message["content"],
            timestamp: message["timestamp"],
            response_to: message['response_to']));
      }
      comments = _comment;
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }
    Widget buildMessageField() {
  return FutureBuilder<void>(
    future: GetComment(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // 显示加载指示器
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // 显示错误消息
      } else {
        return  Row(
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
                          ownername: user.name,
                          ownerphoto: user.profile_picture
                        )),
              );
            },
            child: Text(
              '查看全部${comments.length}則留言',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      );
      }
    },
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
                createReply(Post.id, 1, messagetext);
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
              buildDateField(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(Post.timestamp * 1000))),
              buildLabelField(Post.label.split(","), Post.label),
              buildMessageField(),
              buildInputMessageField()
            ]),
      ),
    );
  }
}
