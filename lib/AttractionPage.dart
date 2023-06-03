import 'package:flutter/material.dart';
import 'PetApp.dart';
import 'StoryPage.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({super.key, required this.name, required this.address, required this.Post_list});
  final List<Posts> Post_list;
  final String name, address;

  @override
  State<AttractionPage> createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> {

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      child: Text(
                        widget.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                      child: Text(
                        widget.address,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Color.fromRGBO(96, 175, 245, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              // Icon(Icons.settings),
              SizedBox(width: 12),
            ],
          ),
          buildImages(),
        ],
      ),
    ),
  );

  Widget buildImages() => SliverToBoxAdapter(
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: widget.Post_list.length,
      itemBuilder: (context, index) {
        return RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryPage(
                      Post_list: widget.Post_list,
                      Post_Index: index,
                    )));
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Card(
              child: Image.network(
                  widget.Post_list[index].post_picture,
                  fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}
