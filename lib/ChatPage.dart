import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Message {
  String text;
  String sender;
  DateTime sentTime;

  Message({required this.text, required this.sender, required this.sentTime});
}

class ChatPage extends StatefulWidget {
  final String chatname;
  final List<Message> messages;
  final String currentUser;

  ChatPage(
      {super.key,
      required this.chatname,
      required this.messages,
      required this.currentUser}) {
    messages.sort((a, b) => b.sentTime.compareTo(a.sentTime));
  }

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool mic_on = false;
  bool _isComposing = false;
  bool _ismicSheetVisible = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addToTextField(String textToAdd) {
    final String currentValue = _textController.text;
    final String newTextValue = currentValue + textToAdd;
    _textController.text = newTextValue;
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    print('please speak');
    await _speechToText.listen(onResult: _onSpeechResult);
    mic_on = !mic_on;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    print('stop speak');
    await _speechToText.stop();
    mic_on = !mic_on;
    _addToTextField(_lastWords);
    _lastWords = '';
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      print(_lastWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.chatname),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
              reverse: true,
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
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: IconButton(
            iconSize: MediaQuery.of(context).size.width / 8,
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            icon: Icon(mic_on ? Icons.mic : Icons.mic_off),
          ),
        ));
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
        borderRadius: BorderRadius.circular(12),
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
          SelectableText(
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
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Flexible(child: messageBox)],
          )
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (FocusScope.of(context).isFirstFocus) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
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
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
      widget.messages.insert(
          0,
          Message(
              text: text,
              sender: widget.currentUser,
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
