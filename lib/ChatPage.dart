import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PetApp.dart';
import 'dart:convert';

class ChatPage extends StatefulWidget {
  final String chatname;
  final List<Message> messages;
  final String currentUser;
  final String photo;
  final int chatID;
  ChatPage(
      {super.key,
      required this.chatname,
      required this.photo,
      required this.messages,
      required this.currentUser,
      required this.chatID}) {
    messages.sort((a, b) => b.sentTime.compareTo(a.sentTime));
  }

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final appBarHeight = AppBar().preferredSize.height;
  final FocusNode _focusNode = FocusNode();
  bool mic_on = false;
  bool _isComposing = false;
  bool _ismicSheetVisible = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 去除阴影
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(96, 175, 245, 1), // 设置返回按钮颜色为蓝色
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.photo),
              radius: appBarHeight / 3,
            ),
            SizedBox(
              width: 8,
            ),
            Text(widget.chatname),
          ])),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
              reverse: true,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final message = widget.messages[index];
                final isMe = message.sender == PetApp.CurrentUser.email;

                return _buildMessage(message, isMe);
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
          _buildSpeechRecognition(),
        ],
      ),
    );
  }

  Widget _buildSpeechRecognition() {
    return Visibility(
      visible: _ismicSheetVisible,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mic_on ? '開始辨識...' : '長按即可錄音辨識寵物情緒',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            IconButton(
              iconSize: MediaQuery.of(context).size.width / 4, // 调整iconSize的值
              onPressed: () {
                if (mic_on == true) {
                  var random = Random();
                  var number = random.nextInt(3);
                  print(number);
                  if (number == 0) {
                    handlePictureSubmmited('assets/pet_emotion/pet_angry.png');
                  } else if (number == 1) {
                    handlePictureSubmmited('assets/pet_emotion/pet_happy.png');
                  } else {
                    handlePictureSubmmited('assets/pet_emotion/pet_sad.png');
                  }
                }

                mic_on = !mic_on;
                setState(() {});
              },
              tooltip: 'Listen',
              icon: mic_on
                  ? Image.asset('assets/image/mic_on.png')
                  : Image.asset('assets/image/mic_off.png'),
            ),
          ],
        ),
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
        color: isMe
            ? Color.fromRGBO(170, 227, 254, 1)
            : Color.fromRGBO(246, 247, 252, 1),
        borderRadius: BorderRadius.circular(20),
        border: !isMe
            ? Border.all(
                color: Color.fromRGBO(96, 175, 245, 1), // 设置边框颜色为蓝色
                width: 1, // 设置边框宽度
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            isMe ? PetApp.CurrentUser.name :
            widget.chatname,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          RichText(
            text: TextSpan(
              children: [
                if (message.isPicture)
                  WidgetSpan(
                    child: Image.asset(
                      message.text,
                      width: 200,
                      height: 200,
                    ),
                  ),
                if (!message.isPicture)
                  TextSpan(
                    text: message.text,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black
                    ),
                  ),
              ],
            ),
          ),
          // SelectableText(
          //   message.text,
          //   style: TextStyle(fontSize: 16.0),
          // ),
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
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Flexible(child: messageBox)],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CircleAvatar(
              //   child: Text(message.sender[0].toUpperCase()),
              // ),
              // SizedBox(width: 8.0),
              messageBox,
            ],
          );
  }

  Widget _buildTextComposer() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (FocusScope.of(context).isFirstFocus) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      },
      child: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.photo,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                _focusNode.unfocus();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.mic,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                _focusNode.unfocus();
                setState(() {
                  _ismicSheetVisible = !_ismicSheetVisible;
                });
              },
            ),
            Expanded(
              child: TextField(
                maxLines: 6,
                minLines: 1,
                focusNode: _focusNode,
                selectionHeightStyle: BoxHeightStyle.max,
                autofocus: true,
                cursorColor: Colors.black,
                controller: _textController,
                onTap: () {
                  _ismicSheetVisible = false;
                },
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                ),
              ),
            ),
            IconButton(
              iconSize: 40,
              icon: Image.asset(
                'assets/image/post_message_submit.png',
              ),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> postMessage(String text) async {
    final response = await http.post(
        Uri.parse("${PetApp.Server_Url}/chat/sendmsg"),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'chat': widget.chatID,
          'owner': PetApp.CurrentUser.email,
          'content': text
        }));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return DateTime.fromMillisecondsSinceEpoch(
          responseData['timestamp'] * 1000);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    return DateTime.now();
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    DateTime receivedAt = await postMessage(text);
    setState(() {
      _isComposing = false;
      widget.messages.insert(
          0,
          Message(
              text: text,
              sender: widget.currentUser,
              isPicture: false,
              sentTime: receivedAt));
    });
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void handlePictureSubmmited(String url) {
    _textController.clear();
    setState(() {
      _isComposing = false;
      widget.messages.insert(
          0,
          Message(
              text: url,
              sender: widget.currentUser,
              isPicture: true,
              sentTime: DateTime.now()));
    });
    FocusScope.of(context).requestFocus(_focusNode);
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
