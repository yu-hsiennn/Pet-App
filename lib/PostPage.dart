import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _newItemController = TextEditingController();
  Widget buildPictureTextField() {
    return Expanded(
      flex: 2, // 20%
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset('assets/image/dog1.jpg'),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter text here',
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> selectedItems = [];

  Widget buildSelectedField() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black),
          ),
        ),
        child: Row(
          children: [
            Text(selectedItems.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget buildLabelField(List<String> items) {
    int rows = (items.length / 3).ceil();
    List<Widget> rowsList = [];

    for (int i = 0; i < rows; i++) {
      List<Widget> buttonsList = [];

      for (int j = i * 3; j < (i + 1) * 3 && j < items.length; j++) {
        buttonsList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                if (selectedItems.contains(items[j])) {
                  selectedItems.remove(items[j]);
                } else {
                  selectedItems.add(items[j]);
                }
                setState(() {});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 1.0, color: Colors.grey)),
              ),
              child: Text(
                items[j],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        );
      }

      rowsList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttonsList,
        ),
      );
    }

    // 加號按鈕
    rowsList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                // 彈出對話框輸入新項目
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("新增項目"),
                    content: TextField(
                      controller: _newItemController,
                      decoration: InputDecoration(hintText: "請輸入新項目"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("取消"),
                      ),
                      TextButton(
                        onPressed: () {
                          String newItem = _newItemController.text.trim();
                          if (newItem.isNotEmpty) {
                            items.add(newItem);
                            selectedItems.add(newItem);
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text("確定"),
                      ),
                    ],
                  ),
                );
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 1.0, color: Colors.grey)),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );

    return Expanded(
      flex: 4,
      child: Column(
        children: rowsList,
      ),
    );
  }

  List<String> items = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5',
    'Button 6',
    'Button 7',
    'Button 8',
    'Button 9'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildPictureTextField(),
        buildSelectedField(),
        buildLabelField(items),
      ],
    ));
  }
}
