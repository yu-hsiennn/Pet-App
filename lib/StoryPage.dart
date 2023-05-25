import 'package:flutter/material.dart';
import 'PetApp.dart';

class StoryPage extends StatefulWidget {
  const StoryPage(
      {super.key, required this.Post_list, required this.Post_Index});
  final List<Post> Post_list;
  final int Post_Index;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ScrollController _scrollController;
  double _scrollOffset = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollOffset = MediaQuery.of(context).size.height;
    _scrollController = ScrollController(
        initialScrollOffset: _scrollOffset * widget.Post_Index * 6 / 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: widget.Post_list.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text(widget.Post_list[index].pictures);
          return buildPost(widget.Post_list[index]);
        },
      ),
    );
  }

  Widget buildPost(Post Post) {
    bool _isVisible = false;

    Widget buildNameTextField(String name, String icon) {
      return Expanded(
        flex: 1, // 20%
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 3),
          dense: true,
          leading: CircleAvatar(
            backgroundImage: AssetImage(icon),
          ),
          title: Text(name),
        ),
      );
    }

    Widget buildPicture(String picture) {
      return Expanded(
        flex: 6, // 20%
        child: Image.network(
          picture,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    Widget buildLikeField(int likeNum) {
      return Expanded(
          flex: 1, // 20%
          child: ListTile(
            visualDensity: const VisualDensity(vertical: 3),
            dense: true,
            leading: Icon(Icons.favorite),
            title: Text(
              "$likeNum個喜歡",
              style: TextStyle(fontSize: 16),
            ),
          ));
    }

    Widget buildTextField(String text) {
      return Expanded(
        flex: 2, // 20%
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    Widget buildLabelField(List<String> label) {
      return Expanded(
          flex: 1, // 20%
          child: Row(
            children: [
              for (var item in label)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(item),
                  ),
                ),
            ],
          ));
    }

    Widget buildMessageField(List<Comment> messages) {
      return Expanded(
          flex: 4, // 20%
          child: Column(
            children: [
              for (int i = 0; i < messages.length; i++)
                if (i < 2)
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(messages[i].user.photo),
                          radius: 15.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(messages[i].comment_info),
                      ),
                    ],
                  )
                else
                  Visibility(
                      visible: _isVisible,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(messages[i].user.photo),
                              radius: 15.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(messages[i].comment_info),
                          ),
                        ],
                      )),
              if (messages.length > 2)
                Visibility(
                  visible: !_isVisible,
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: TextButton(
                            child: Text('查看全部留言'),
                            onPressed: () {
                              setState(() {
                                _isVisible = true;
                              });
                            },
                          )),
                    ],
                  ),
                )
            ],
          ));
    }

    Widget buildInputMessageField(String usericon) {
      return Expanded(
          flex: 1, // 20%
          child: Row(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "新增留言...",
                          prefixIcon: CircleAvatar(
                            backgroundImage: NetworkImage(usericon),
                            radius: 15.0,
                          )),
                    )),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // 这里可以写提交操作的代码
                },
                icon: Icon(Icons.near_me),
              ),
            ],
          ));
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: MediaQuery.of(context).size.height * 6 / 7,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildNameTextField(Post.poster.name, Post.poster.photo),
              buildPicture(Post.pictures),
              buildLikeField(Post.like_count),
              buildTextField(Post.post_info),
              buildLabelField(Post.label),
              buildMessageField(Post.comments),
              buildInputMessageField(Post.poster.photo)
            ]),
      ),
    );
  }
}
