import 'package:flutter/material.dart';
import 'SearchLocationPage.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _newItemController = TextEditingController();
  String location = "新增地點";
  Widget buildPictureField() {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/image/dog1.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  List<String> selectedItems = [];

  Widget buildSelectedField() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }

  Widget buildLabelField(List<String> items) {
    int rows = (items.length / 5).ceil();
    List<Widget> rowsList = [];

    for (int i = 0; i < rows; i++) {
      List<Widget> buttonsList = [];

      for (int j = i * 5; j < (i + 1) * 5 && j < items.length; j++) {
        buttonsList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: OutlinedButton(
              onPressed: () {
                if (selectedItems.contains(items[j])) {
                  selectedItems.remove(items[j]);
                } else {
                  if (selectedItems.length < 5) {
                    selectedItems.add(items[j]);
                  }
                }
                setState(() {});
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 8.0)),
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

    return Container(
      width: double.infinity,
      // height: 50,
      child: Expanded(
        flex: 2,
        child: Column(
          children: rowsList,
        ),
      ),
    );
  }

  List<String> items = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5',
  ];
  Widget buildInputField() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: '輸入說明文字...',
            border: InputBorder.none,
          ),
          maxLines: null,
          textInputAction: TextInputAction.newline,
        ),
      ),
    );
  }

  Widget buildLocationButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: OutlinedButton(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    location,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchLocationPage()),
            ).then((value) {
              setState(() {
                location = value ?? '新增地點';
              });
              // Do something with returned data
            });
          },
        ),
      ),
    );
  }

  Widget buildTextField(String Word) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$Word',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildPictureField(),
        buildLocationButton(),
        buildTextField('新增貼文標籤'),
        buildSelectedField(),
        buildLabelField(items),
        buildTextField('輸入貼文說明'),
        buildInputField(),
      ],
    ));
  }
}
