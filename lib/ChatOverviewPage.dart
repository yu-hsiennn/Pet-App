import 'package:flutter/material.dart';
import 'ChatPage.dart';

class Chat {
  String name;
  String lastMessage;
  DateTime lastActive;

  Chat(
      {required this.name,
      required this.lastMessage,
      required this.lastActive});
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

  @override
  Widget build(BuildContext context) {
    final groupedChats = _groupChatsBySender();
    final latestChats = _getLatestChats(groupedChats);

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
                            color: Color.fromRGBO(96, 175, 245, 1), // 蓝色底线颜色
                            width: 1.0, // 蓝色底线宽度
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(chat.name[0].toUpperCase()),
                        ),
                        title: Text(chat.name),
                        subtitle:
                            Text('${chat.lastMessage} · $lastActiveString'),
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

  Map<String, List<Chat>> _groupChatsBySender() {
    final groupedChats = <String, List<Chat>>{};
    for (final chat in widget.chats) {
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
          chatname: 'aChatName',
          photo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYWRSDNv7PjuDHov3_3supR5DR_eaLnDgg7A&usqp=CAU',
          messages: chatContent,
          currentUser: 'felix',
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
