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

class ChatOverviewPage extends StatelessWidget {
  final List<Chat> chats;

  ChatOverviewPage({super.key, required this.chats}) {
    chats.sort((a, b) => b.lastActive.compareTo(a.lastActive));
  }

  @override
  Widget build(BuildContext context) {
    final groupedChats = _groupChatsBySender();
    final latestChats = _getLatestChats(groupedChats);

    return Scaffold(
      body: ListView.builder(
        itemCount: latestChats.length,
        itemBuilder: (context, index) {
          final chat = latestChats[index];
          final lastActiveDuration = DateTime.now().difference(chat.lastActive);
          final lastActiveString = _getLastActiveString(lastActiveDuration);

          return ListTile(
            leading: CircleAvatar(
              child: Text(chat.name[0].toUpperCase()),
            ),
            title: Text(chat.name),
            subtitle: Text('${chat.lastMessage} · $lastActiveString'),
            onTap: () => _openChatPage(context, chat),
          );
        },
      ),
    );
  }

  Map<String, List<Chat>> _groupChatsBySender() {
    final groupedChats = <String, List<Chat>>{};
    for (final chat in chats) {
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
