import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'PetApp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatOverviewPage extends StatefulWidget {
  late List<Chat> chats;

  ChatOverviewPage({Key? key}) : super(key: key);

  @override
  _ChatOverviewPageState createState() => _ChatOverviewPageState();
}

class _ChatOverviewPageState extends State<ChatOverviewPage> {
  String searchText = '';
  String GetUserUrl = PetApp.Server_Url + '/user/';

  Future<List<Chat>> getUserChats() async {
    List<Chat> chats = [];
    List<Chat> _chats = [];
    final response = await http.get(
      Uri.parse("${PetApp.Server_Url}/user/${PetApp.CurrentUser.email}/chats"),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var serverChat in responseData) {
        String chatname;
        if (serverChat['user1'] == PetApp.CurrentUser.email) {
          chatname = serverChat['user2'];
        } else {
          chatname = serverChat['user1'];
        }
        chats.add(Chat(
            id: serverChat['id'],
            ownerId: chatname,
            name: "",
            lastMessage: '_temp_fake_last_msg',
            lastActive: DateTime.now()));
      }
      //download all chat contents in one go
      for (Chat chat in chats) {
        chat.chatContent = await getChatContent(chat);

        chat.lastMessage = chat.chatContent.isEmpty
            ? ""
            : chat.chatContent[chat.chatContent.length - 1].text;
        chat.lastActive = chat.chatContent.isEmpty
            ? DateTime.now()
            : chat.chatContent[chat.chatContent.length - 1].sentTime;
        var u = await _GetUser(chat.ownerId);
        chat.name = u.name;
      }
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    for (var c in chats) {
      if (c.lastMessage.contains(searchText) || c.name.contains(searchText)) {
        _chats.add(c);
      }
    }
    return _chats;
  }

  Future<List<Message>> getChatContent(Chat chat) async {
    List<Message> messages = [];
    // String _fileId = "";
    final response = await http.get(
      Uri.parse("${PetApp.Server_Url}/chat/${chat.id}/messages"),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var servermsg in responseData) {
        // if (servermsg['files'] != []) {
        //   _fileId = servermsg['files'][0]['file_path'].split("/")[1].split(".")[0];
        // }
        messages.add(Message(
            // text: servermsg['files'] == [] ? servermsg['content'] : "${PetApp.Server_Url}/file/$_fileId",
            text: servermsg['content'],
            sender: servermsg['owner'],
            isPicture: servermsg['files'] == [] ? false : false,
            sentTime: DateTime.fromMillisecondsSinceEpoch(
                servermsg['timestamp'] * 1000)));
      }
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    return messages;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '聊天室',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(246, 247, 252, 1),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '搜尋',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '訊息',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Chat>>(
                future: getUserChats(),
                builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else { 
                    final latestChats =
                        _getLatestChats(_groupChatsBySender(snapshot.data));
                    return ListView.builder(
                      itemCount: latestChats.length,
                      itemBuilder: (context, index) {
                        final chat = latestChats[index];
                        final lastActiveDuration =
                            DateTime.now().difference(chat.lastActive);
                        final lastActiveString =
                            _getLastActiveString(lastActiveDuration);
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(
                                      96, 175, 245, 1), // 蓝色底线颜色
                                  width: 1.0, // 蓝色底线宽度
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(chat.name[0].toUpperCase()),
                                backgroundImage: NetworkImage(
                                    "${PetApp.Server_Url}/user/${chat.ownerId}/profile_picture"),
                                backgroundColor: Colors.white,
                              ),
                              title: Text(chat.name),
                              subtitle: Text(
                                  '${chat.lastMessage} · $lastActiveString'),
                              onTap: () => _openChatPage(context, chat),
                            ),
                          ),
                        );
                      },
                    );
                }}),
              )
            ],
          ),
        ),
      );
  }

  Map<String, List<Chat>> _groupChatsBySender(List<Chat>? chats) {
    final groupedChats = <String, List<Chat>>{};
    for (final chat in chats!) {
      final sender = chat.ownerId;
      if (!groupedChats.containsKey(sender)) {
        groupedChats[sender] = [];
      }
      groupedChats[sender]!.add(chat);
    }
    return groupedChats;
  }

  List<Chat> _getLatestChats(Map<String, List<Chat>> groupedChats) {
    final latestChats = <Chat>[];
    for (final senderChats in groupedChats.values) {
      senderChats.sort((a, b) => b.lastActive.compareTo(a.lastActive));
      latestChats.add(senderChats.first);
    }
    return latestChats;
  }

  String _getLastActiveString(Duration lastActiveDuration) {
    if (lastActiveDuration.inDays > 0) {
      return '${lastActiveDuration.inDays}d ago';
    } else if (lastActiveDuration.inHours > 0) {
      return '${lastActiveDuration.inHours}h ago';
    } else if (lastActiveDuration.inMinutes > 0) {
      return '${lastActiveDuration.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  void _openChatPage(BuildContext context, Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          chatname: chat.name,
          photo: "${PetApp.Server_Url}/user/${chat.ownerId}/profile_picture",
          messages: chat.chatContent,
          currentUser: PetApp.CurrentUser.email,
          chatID: chat.id,
        ),
      ),
    );
  }
}
