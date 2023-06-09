import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pet_app/PetApp.dart';
import 'package:http/http.dart' as http;
import 'MainPage.dart';
import 'ProfilePage.dart';
import 'dart:core';
import 'package:intl/intl.dart';

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
  User ownerUser = new User(email: "", name: "", intro: "", locations: "", password: "");
  List<Comment> comments = [];
  HashMap<String, User> userMap = HashMap<String, User>();
  String GetUserUrl = PetApp.Server_Url + '/user/';

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
              label: post['label'],
              content: post["content"],
              id: post["id"],
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

      ownerUser.email = responseData['email'];
      ownerUser.name = responseData['name'];
      ownerUser.intro = responseData['intro'];
      ownerUser.posts = _post;
      ownerUser.pets = _pet;
      ownerUser.profile_picture =
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
        return ListTile(
          visualDensity: const VisualDensity(vertical: 3),
          dense: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color:Color.fromRGBO(96, 175, 245, 1) ,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(Is_Me: false, user: ownerUser),
                ),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.ownerphoto),
                ),
                SizedBox(width: 8), // Add spacing
                Text(
                  widget.ownername,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    },
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
  
  Future<void> GetComment() async {
    List<Comment> _comment = [];
    final response = await http.get(
        Uri.parse(PetApp.Server_Url + '/posts/{post_id}/replies?postid=${widget.post.id}'),
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

  Future<User> _GetUser(String ownerId) async {
    User user = new User(email: "", name: "", intro: "", locations: "", password: "");
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
              label: post['label'],
              id: post["id"],
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
    return user;
  }

  Future<void> GetCommentHandler() async {
    await GetComment();

    for (var c in comments) {
      if (userMap.containsKey(c.owner_id)) {
        continue;
      }
      userMap[c.owner_id] = await _GetUser(c.owner_id);;
    }
  }

  Widget buildMessageField() {
  return FutureBuilder<void>(
    future: GetCommentHandler(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // 显示加载指示器
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // 显示错误消息
      } else {
        return Column(
  children: [
    for (int i = 0; i < comments.length; i++)
      Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(Is_Me: false, user: userMap[comments[i].owner_id]!)),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "${PetApp.Server_Url}/user/${comments[i].owner_id}/profile_picture",
                ),
                radius: 15.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userMap[comments[i].owner_id]!.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(comments[i].content),
              ],
            ),
          ),
        ],
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
  


void _onItemTapped(int index) {
  
  // Navigate to the corresponding page based on the index
  switch (index) {
    case 0:
      // Home Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 0)),
      );
      break;
    case 1:
      // Search Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 1)),
      );
      break;
    case 2:
      // Favorites Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MainPage(current_index: 2)),
      );
      break;
    case 3:
      // Profile Page
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
                      ..color = Colors.black),
              ),
              Text(
                "PETSHARE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildNameTextField(widget.post.owner_id),
            SizedBox(height: 20),
            buildPicture(widget.post.post_picture),
            buildLikeField(widget.post.Likes.length),
            buildTextField(widget.post.content),
            buildDateField(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(widget.post.timestamp * 1000))),
            buildLabelField(widget.post.label.split(",")),
            Divider(
              // 添加蓝色线
              color: Color.fromRGBO(170, 227, 254, 1),
              thickness: 1,
            ),
            buildMessageField(),
            buildInputMessageField()
          ]),
    ))),
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
}
