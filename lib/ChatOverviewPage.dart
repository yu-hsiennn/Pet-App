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
  Message(text: 'hi', sender: 'friend1', sentTime: DateTime.now()),
  Message(text: 'hello', sender: 'felix', sentTime: DateTime.now()),
  Message(
      text: 'asdlfka;sdlfkaslkdf',
      sender: 'friend1',
      sentTime: DateTime.parse('2023-05-04 14:00')),
  Message(text: 'hi', sender: 'friend1', sentTime: DateTime.now()),
  Message(text: 'hi', sender: 'friend1', sentTime: DateTime.now()),
  Message(text: 'hi', sender: 'felix', sentTime: DateTime.now()),
  Message(text: 'hi', sender: 'friend1', sentTime: DateTime.now()),
];

class ChatOverviewPage extends StatelessWidget {
  final List<Chat> chats;

  ChatOverviewPage({super.key, required this.chats}) {
    chats.sort((a, b) => b.lastActive.compareTo(a.lastActive));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
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
                  messages: chatContent,
                  currentUser: 'felix',
                )));
  }
}
