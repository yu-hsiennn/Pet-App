import 'package:flutter/material.dart';

class Chat {
  String name;
  String lastMessage;
  DateTime lastActive;

  Chat(
      {required this.name,
      required this.lastMessage,
      required this.lastActive});
}

class ChatOverviewPage extends StatelessWidget {
  final List<Chat> chats;

  ChatOverviewPage({required this.chats});

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
              child: Text(chat.name[0]),
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
    // Navigate to chat page
  }
}
