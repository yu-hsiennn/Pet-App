import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'PetApp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Chat {
  int id;
  String name;
  String lastMessage;
  DateTime lastActive;
  List<Message> chatContent = [];
  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastActive,
  });
}

List<Message> chatContent = [
  Message(
      text: 'hi',
      sender: 'friend1',
      isPicture: false,
      sentTime: DateTime.now()),
  Message(
      text: 'hello',
      sender: 'felix',
      isPicture: false,
      sentTime: DateTime.now()),
  Message(
      text: 'asdlfka;sdlfkaslkdf',
      sender: 'friend1',
      isPicture: false,
      sentTime: DateTime.parse('2023-05-04 14:00')),
  Message(
      text: 'hi',
      sender: 'friend1',
      isPicture: false,
      sentTime: DateTime.now()),
  Message(
      text: 'hi',
      sender: 'friend1',
      isPicture: false,
      sentTime: DateTime.now()),
  Message(
      text: 'hi', sender: 'felix', isPicture: false, sentTime: DateTime.now()),
  Message(
      text: 'hi',
      sender: 'friend1',
      isPicture: false,
      sentTime: DateTime.now()),
];

class ChatOverviewPage extends StatefulWidget {
  late List<Chat> chats;

  ChatOverviewPage({Key? key}) : super(key: key);

  @override
  _ChatOverviewPageState createState() => _ChatOverviewPageState();
}

class _ChatOverviewPageState extends State<ChatOverviewPage> {
  String searchText = '';

  Future<List<Chat>> getUserChats() async {
    List<Chat> chats = [];
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
            name: chatname,
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
      }
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    return chats;
  }

  Future<List<Message>> getChatContent(Chat chat) async {
    List<Message> messages = [];
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
        messages.add(Message(
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chat>>(
        future: getUserChats(),
        builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            final latestChats =
                _getLatestChats(_groupChatsBySender(snapshot.data));
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
                      child: ListView.builder(
                        itemCount: latestChats.length,
                        itemBuilder: (context, index) {
                          final chat = latestChats[index];
                          final lastActiveDuration =
                              DateTime.now().difference(chat.lastActive);
                          final lastActiveString =
                              _getLastActiveString(lastActiveDuration);

                          if (searchText.isNotEmpty &&
                              !chat.name
                                  .toLowerCase()
                                  .contains(searchText.toLowerCase())) {
                            return Container(); // Skip rendering if the name doesn't match the search text
                          }

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
                                ),
                                title: Text(chat.name),
                                subtitle: Text(
                                    '${chat.lastMessage} · $lastActiveString'),
                                onTap: () => _openChatPage(context, chat),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  Map<String, List<Chat>> _groupChatsBySender(List<Chat>? chats) {
    final groupedChats = <String, List<Chat>>{};
    for (final chat in chats!) {
      final sender = chat.name;
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
          photo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYWRSDNv7PjuDHov3_3supR5DR_eaLnDgg7A&usqp=CAU',
          messages: chat.chatContent,
          currentUser: PetApp.CurrentUser.email,
        ),
      ),
    );
  }
}
// class ChatOverviewPage extends StatelessWidget {
//   final List<Chat> chats;

//   ChatOverviewPage({super.key, required this.chats}) {
//     chats.sort((a, b) => b.lastActive.compareTo(a.lastActive));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: chats.length,
//         itemBuilder: (context, index) {
//           final chat = chats[index];
//           final lastActiveDuration = DateTime.now().difference(chat.lastActive);
//           final lastActiveString = _getLastActiveString(lastActiveDuration);

//           return ListTile(
//             leading: CircleAvatar(
//               child: Text(chat.name[0].toUpperCase()),
//             ),
//             title: Text(chat.name),
//             subtitle: Text('${chat.lastMessage} · $lastActiveString'),
//             onTap: () => _openChatPage(context, chat),
//           );
//         },
//       ),
//     );
//   }

//   String _getLastActiveString(Duration lastActiveDuration) {
//     if (lastActiveDuration.inDays > 0) {
//       return '${lastActiveDuration.inDays}d ago';
//     } else if (lastActiveDuration.inHours > 0) {
//       return '${lastActiveDuration.inHours}h ago';
//     } else if (lastActiveDuration.inMinutes > 0) {
//       return '${lastActiveDuration.inMinutes}m ago';
//     } else {
//       return 'now';
//     }
//   }

//   void _openChatPage(BuildContext context, Chat chat) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ChatPage(
//                   chatname: 'aChatName',
//                   photo:
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYWRSDNv7PjuDHov3_3supR5DR_eaLnDgg7A&usqp=CAU',
//                   messages: chatContent,
//                   currentUser: 'felix',
//                 )));
//   }
// }
