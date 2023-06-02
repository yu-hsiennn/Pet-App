import 'package:flutter/material.dart';
import 'PetApp.dart';
import 'SearchLocationPage.dart';
import 'MainPage.dart';

UserData demoUser1 = UserData(
  name: "peach",
  username: 'demouser',
  password: 'demopw',
  follower: 116,
  pet_count: 2,
  intro: "aasddf",
  photo: "assets/image/peach.jpg",
  petdatas: [demoPet1, demoPet2],
);

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _newItemController = TextEditingController();
  String location = "新增地點";
  Widget buildPictureField() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              // 點擊事件處理程式碼
              print('點擊了圖片');
            },
            child: Image.asset(
              'assets/image/NonePicture.png',
              width: constraints.maxWidth, // 螢幕寬度的一半
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  List<String> selectedItems = [];

  Widget buildSelectedField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(width: 1.0, color: Color.fromRGBO(170, 227, 254, 1)),
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
    List<int> pattern = [3, 4, 3, 4, 3, 4]; // 数量模式
    List<Widget> rowsList = [];

    int itemCount = 0;
    int row = 0;
    while (itemCount < items.length) {
      List<Widget> buttonsList = [];
      int rowButtonsCount = pattern[row % pattern.length];

      for (int j = itemCount;
          j < itemCount + rowButtonsCount && j < items.length;
          j++) {
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
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(170, 227, 254, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width / 6,
                      double.infinity), // 设置按钮的最大宽度
                ),
              ),
              child: Text(
                items[j],
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ),
        );
      }

      itemCount += rowButtonsCount;
      row++;

      rowsList.add(
        Wrap(
          spacing: 8.0, // 按钮之间的水平间距
          runSpacing: 8.0, // 按钮之间的垂直间距
          alignment: WrapAlignment.center,
          children: buttonsList,
        ),
      );
    }

    rowsList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "新增label",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: TextField(
                      controller: _newItemController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(170, 227, 254, 1),
                          ),
                        ),
                        hintText: '輸入新label...',
                      ),
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
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(170, 227, 254, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      child: Column(
        children: rowsList,
      ),
    );
  }

  // Widget buildLabelField(List<String> items) {
  //   int rows = (items.length / 4).ceil();
  //   List<Widget> rowsList = [];

  //   for (int i = 0; i < rows; i++) {
  //     List<Widget> buttonsList = [];

  //     for (int j = i * 4; j < (i + 1) * 4 && j < items.length; j++) {
  //       buttonsList.add(
  //         Padding(
  //           padding: EdgeInsets.symmetric(vertical: 4.0),
  //           child: OutlinedButton(
  //             onPressed: () {
  //               if (selectedItems.contains(items[j])) {
  //                 selectedItems.remove(items[j]);
  //               } else {
  //                 if (selectedItems.length < 4) {
  //                   selectedItems.add(items[j]);
  //                 }
  //               }
  //               setState(() {});
  //             },
  //             style: ButtonStyle(
  //               padding: MaterialStateProperty.all<EdgeInsets>(
  //                   EdgeInsets.symmetric(horizontal: 8.0)),
  //               backgroundColor: MaterialStateProperty.all<Color>(
  //                   Color.fromRGBO(170, 227, 254, 1)),
  //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                 ),
  //               ),
  //             ),
  //             child: Text(
  //               items[j],
  //               style: TextStyle(fontSize: 16.0, color: Colors.black),
  //             ),
  //           ),
  //         ),
  //       );
  //     }

  //     rowsList.add(
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: buttonsList,
  //       ),
  //     );
  //   }

  //   // 加號按鈕
  //   rowsList.add(
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.symmetric(vertical: 8.0),
  //           child: OutlinedButton(
  //             onPressed: () {
  //               // 彈出對話框輸入新項目
  //               showDialog(
  //                 context: context,
  //                 builder: (context) => AlertDialog(
  //                   title: Text(
  //                     "新增label",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   content: TextField(
  //                     controller: _newItemController,
  //                     decoration: InputDecoration(
  //                       border: InputBorder.none, // 去除边框
  //                       enabledBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(
  //                             color: Color.fromRGBO(
  //                                 170, 227, 254, 1)), // 设置底线颜色为蓝色
  //                       ),
  //                       hintText: '輸入新label...',
  //                     ),
  //                   ),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text("取消"),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         String newItem = _newItemController.text.trim();
  //                         if (newItem.isNotEmpty) {
  //                           items.add(newItem);

  //                           setState(() {});
  //                           Navigator.pop(context);
  //                         }
  //                       },
  //                       child: Text("確定"),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //             style: ButtonStyle(
  //               padding: MaterialStateProperty.all<EdgeInsets>(
  //                   EdgeInsets.symmetric(horizontal: 16.0)),
  //               backgroundColor: MaterialStateProperty.all<Color>(
  //                   Color.fromRGBO(170, 227, 254, 1)),
  //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //                 RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                 ),
  //               ),
  //             ),
  //             child: Icon(
  //               Icons.add,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   return Container(
  //     width: double.infinity,
  //     // height: 50,

  //     child: Column(
  //       children: rowsList,
  //     ),
  //   );
  // }

  List<String> items = [
    '飛盤',
    '接球',
    '散步',
    '捉迷藏',
    '慢跑',
    '衝刺',
    '笨狗',
  ];
  Widget buildInputField() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '輸入說明文字...',
          border: InputBorder.none,
        ),
        maxLines: null,
        textInputAction: TextInputAction.newline,
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
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_forward,
                    color: Color.fromRGBO(170, 227, 254, 1)),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Color.fromRGBO(170, 227, 254, 1)),
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
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            '新貼文',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(96, 175, 245, 1),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                    builder: (context) => new MainPage(
                          user: demoUser1,
                        )),
                (route) => route == null,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MainPage(
                            user: demoUser1,
                          )),
                  (route) => route == null,
                );
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                buildPictureField(),
                buildLocationButton(),
                buildTextField('新增貼文標籤'),
                buildSelectedField(),
                buildLabelField(items),
                buildTextField('輸入貼文說明'),
                buildInputField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
