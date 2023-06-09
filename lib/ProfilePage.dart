import 'package:flutter/material.dart';
import 'package:pet_app/AddPetProfile.dart';
import 'package:pet_app/StoryPage.dart';
import 'MainPage.dart';
import 'PetApp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ChatPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.Is_Me, required this.user, required this.followed,required this.extra_Appbar});
  final bool Is_Me, followed,extra_Appbar;
  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustomWidget cw = new CustomWidget();
  String gender = "";
  bool isEditing = false;
  TextEditingController myTextController = TextEditingController();
  late User u;
  late bool followed;
  int ChatId = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.Is_Me) {
      u = widget.user;
      followed = widget.followed;
    } else {
      u = PetApp.CurrentUser;
    }
  }

  void _onItemTapped(int index) {

  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 0)),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 1)),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MainPage(current_index: 2)),
      );
      break;
    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage(current_index: 3)),
      );
      break;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Color.fromRGBO(96, 175, 245, 1), size: 30),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          u.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // Added height to the container
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                profile_info(u.profile_picture, u.posts.length,
                    u.Follower.length, u.Following.length, widget.Is_Me),
                Text_info(widget.Is_Me),
                Text_title("寵物資料"),
                Pets_photo(u.pets, widget.Is_Me),
                Text_title("寵物相簿"),
                Album(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible:widget.extra_Appbar, 
        child:BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 20),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_outlined,
              color: Colors.blue,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
              color: Colors.blue,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: Colors.blue, Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),),
      
    );
  }

  Widget profile_info(String file_name, int posts_count, int followers,
      int following, bool is_user) {
    if (is_user) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: cw.Profile_photo(35, file_name: file_name),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: cw.Text_count("追蹤者", followers),
                      flex: 1,
                    ),
                    Spacer(),
                    Flexible(
                      child: cw.Text_count("追蹤中", following),
                      flex: 1,
                    ),
                    Spacer(),
                    Flexible(
                      child: cw.Text_count("貼文數", posts_count),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ));
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: cw.Profile_photo(35, file_name: file_name),
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: cw.Text_count("追蹤者", followers),
                        flex: 1,
                      ),
                      Spacer(),
                      Flexible(
                        child: cw.Text_count("追蹤中", following),
                        flex: 1,
                      ),
                      Spacer(),
                      Flexible(
                        child: cw.Text_count("貼文數", posts_count),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ToggleFollow();
                            followed = !followed;
                            setState(() {
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(170, 227, 254, 1),
                          ),
                          child: Text(
                            !followed ? '追蹤' : '已追蹤',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () async {
                            Chat c = await getUserChats();
                            print(c.chatContent.length);
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  chatname: u.name,
                                  photo: "${PetApp.Server_Url}/user/${u.email}/profile_picture",
                                  messages: c.id == 0 ? [] : c.chatContent,
                                  currentUser: PetApp.CurrentUser.email,
                                  chatID: c.id == 0 ? ChatId : c.id,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromRGBO(170, 227, 254, 1), // 设置背景颜色为蓝色
                          ),
                          child: Text(
                            '聊天',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold, // 设置字体颜色为黑色
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ],
        ));
  }

  Widget Text_title(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Text_info(bool is_user) {
    return Column(
      children: [
        Row(
          children: [
            Text_title("飼主簡介"),
            if (is_user)
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                icon: Icon(Icons.mode_edit),
              ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(96, 175, 245, 1),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              )),
          child: isEditing
              ? TextField(
                  controller:
                      myTextController,
                  style: TextStyle(fontSize: 18.0),
                  onSubmitted: (String value) {
                    setState(() {
                      isEditing = false;
                      u.intro = value; // 将文本保存到info变量中
                      EditIntroduce();
                    });
                  },
                )
              : Text(
                  u.intro,
                  style: TextStyle(fontSize: 18.0),
                ),
        ),
      ],
    );
  }

  Future<void> EditIntroduce() async {
    String editIntroduceUrl = PetApp.Server_Url + '/user/edit';
    final response = await http.post(
      Uri.parse(editIntroduceUrl),
      headers: {
        'accept': 'application/json',
        'Authorization': "Bearer " + u.authorization,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": PetApp.CurrentUser.email,
        "name": PetApp.CurrentUser.name,
        "intro": u.intro,
        "location": PetApp.CurrentUser.locations,
        "birthday": "2023/6/7",
        "password": PetApp.CurrentUser.password
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> CreatePet(String petname, String petbreed, String petbirthday,
      String petgender, String petlabel, String petPhoto) async {
    String createPetUrl = PetApp.Server_Url + '/pet/createOrEdit';
    final response = await http.post(
      Uri.parse(createPetUrl),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ' + u.authorization,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "owner": u.email,
        "name": petname,
        "breed": petbreed,
        "gender": petgender,
        "birthday": petbirthday,
        "personality_labels": petlabel
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      uploadPetImage(petPhoto, responseData['id']);
      print(responseData);
      print('create success');
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> GetPets(String email) async {
    List<Pet> _pet = [];
    String getPetUrl = PetApp.Server_Url + '/user/' + email + '/pets/';
    final response = await http.get(Uri.parse(getPetUrl), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      for (var pets in responseData) {
        var temp1 = pets['files'][0]['file_path'].split("/");
        var temp2 = temp1[1].split(".");
        _pet.add(Pet(
            owner: pets['owner'],
            birthday: pets['birthday'],
            breed: pets['breed'],
            gender: pets['gender'],
            id: pets['id'],
            name: pets['name'],
            personality_labels: pets['personality_labels'],
            picture: "${PetApp.Server_Url}/file/${temp2[0]}"));
      }

      PetApp.CurrentUser.pets = _pet;
      setState(() {});
      print(responseData);
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> ToggleFollow() async {
    final response = await http.post(
      Uri.parse("${PetApp.Server_Url}/user/follow"),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
      body: jsonEncode({
        'follower': PetApp.CurrentUser.email,
        'follows': u.email,
      }),
    );

    if (response.statusCode == 200) {
      // final responseData = json.decode(response.body);
      // followed = responseData['like_status'] == 0 ? false : true;
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<void> CreateChat() async {
    final response = await http.post(
      Uri.parse("${PetApp.Server_Url}/chat/create"),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
      body: jsonEncode({
        'user1': PetApp.CurrentUser.email,
        'user2': u.email,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ChatId = responseData['id'];
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
  }

  Future<Chat> getUserChats() async {
    Chat chats = new Chat(id: 0, name: "", lastMessage: "", lastActive: DateTime.now(), ownerId: "");
    final response = await http.get(
      Uri.parse("${PetApp.Server_Url}/user/${PetApp.CurrentUser.email}/chats"),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var serverChat in responseData) {
        if (serverChat['user2'] == u.email || serverChat['user1'] == u.email) {
          chats.id = serverChat['id'];
          chats.ownerId = u.email;
          chats.name = u.name;
        }
      }
      if (chats.id == 0) {
        await CreateChat();
      } else {
        chats.chatContent = await getChatContent(chats);
        chats.lastMessage = chats.chatContent.isEmpty
            ? ""
            : chats.chatContent[chats.chatContent.length - 1].text;
        chats.lastActive = chats.chatContent.isEmpty
            ? DateTime.now()
            : chats.chatContent[chats.chatContent.length - 1].sentTime;
      }
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    return chats;
  }

  Future<List<Message>> getChatContent(Chat chat) async {
    List<Message> messages = [];
    // String _fileId = "";
    final response = await http.get(
      Uri.parse("${PetApp.Server_Url}/chat/${chat.id}/messages"),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${PetApp.CurrentUser.authorization}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      for (var servermsg in responseData) {
        // if (servermsg['files'] != []) {
        //   _fileId = servermsg['files'][0]['file_path'].split("/")[1].split(".")[0];
        // }
        messages.add(Message(
            // text: servermsg['files'] == [] ? servermsg['content'] : "${PetApp.Server_Url}/file/$_fileId",
            text: servermsg['content'],
            sender: servermsg['owner'],
            isPicture: servermsg['files'] == [] ? false : false,
            sentTime: DateTime.fromMillisecondsSinceEpoch(
                servermsg['timestamp'] * 1000)));
      }
    } else {
      print(
          'Request failed with status: ${json.decode(response.body)['detail']}.');
    }
    return messages;
  }

  Map<String, List<Chat>> _groupChatsBySender(List<Chat>? chats) {
    final groupedChats = <String, List<Chat>>{};
    for (final chat in chats!) {
      final sender = chat.ownerId;
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

  Future<void> uploadPetImage(String PetPhotoPath, int petid) async {
    print(PetPhotoPath);
    var upUrl =
        Uri.parse("${PetApp.Server_Url}/pet/$petid/file?fileending=jpg");
    print(upUrl);
    var request = http.MultipartRequest('POST', upUrl);
    request.headers.addAll({
      'accept': 'application/json',
      'Authorization': "Bearer ${u.authorization}",
      'Content-Type': 'multipart/form-data'
    });
    print(PetPhotoPath);
    request.files.add(await http.MultipartFile.fromPath('file', PetPhotoPath));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Pet picture uploaded successfully');
      GetPets(u.email);
    } else {
      print(
          'Failed to upload profile picture. Status code: ${response.statusCode}');
    }
  }

  Widget Pets_photo(List<Pet> petsList, bool isUser) {

    return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...petsList.map((pet) {
              return GestureDetector(
                onTap: () {
                  showPetProfile(pet);
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 20.0), // Add spacing between items
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(pet.picture),
                  ),
                ),
              );
            }).toList(),
            if (isUser)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPetProfilePage()),
                  ).then((value) {
                    if (value[0] != '') {
                      setState(() {
                        CreatePet(value[0], value[1], value[2], value[3],
                            value[4], value[5]);
                      });
                    }
                    print(value);
                  });
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 10.0), // Add spacing between items
                  child: CircleAvatar(
                    radius: 35,
                    foregroundImage: AssetImage('assets/image/AddPetProfile.png'),
                  ),
                ),
              ),
          ],
        ),),
    ),
    );
  }

  Future<dynamic> showPetProfile(Pet pet) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        var dialogWidth = screenSize.width * 1 / 2;
        var dialogHeight = screenSize.height * 1 / 2;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                color: Color.fromRGBO(96, 175, 245, 1),
                width: 3.0), // Add the desired blue color
          ),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 30.0),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(pet.picture),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            pet.name,
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Text(pet.breed, style: TextStyle(fontSize: 16.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${pet.birthday.toString()}',
                              style: TextStyle(fontSize: 16.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${pet.gender}',
                              style: TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft, // Align left
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0), // Add left padding
                    child: Text(
                      '個性標籤',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                  padding: EdgeInsets.only(left: 30.0), // Add left padding
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align left
                      children: List.generate(
                        pet.personality_labels.split(',').length,
                        (index) => Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(170, 227, 254,
                                1), // Add the desired background color
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(pet.personality_labels.split(',')[index]),
                        ),
                      ),
                    ),
                  ),
                ),
                )
                
                
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Album(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < u.posts.length; index += 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = index; i < index + 3 && i < u.posts.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 0,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoryPage(
                                      Post_list: u.posts, Post_Index: index)),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              u.posts[i].post_picture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
