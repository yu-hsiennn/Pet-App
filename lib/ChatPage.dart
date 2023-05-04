import 'package:flutter/material.dart';

class Message {
  String text;
  String sender;
  DateTime sentTime;

  Message({required this.text, required this.sender, required this.sentTime});
}

class ChatPage extends StatefulWidget {
  final List<Message> messages;
  final String currentUser;

  ChatPage({required this.messages, required this.currentUser});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
              reverse: false,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];
                final isMe = message.sender == widget.currentUser;
                return _buildMessage(message, isMe);
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message, bool isMe) {
    final messageBox = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 80.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[300] : Colors.blue[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.sender,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            message.text,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 4.0),
          Text(
            _getMessageTime(message.sentTime),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );

    return isMe
        ? messageBox
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: Text(message.sender[0].toUpperCase()),
              ),
              SizedBox(width: 8.0),
              messageBox,
            ],
          );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () => _handleSubmitted(_textController.text)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
      widget.messages.add(Message(
          text: text, sender: widget.currentUser, sentTime: DateTime.now()));
    });
  }

  String _getMessageTime(DateTime sentTime) {
    final now = DateTime.now();
    final difference = now.difference(sentTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
