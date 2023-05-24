import 'package:flutter/material.dart';
import 'PetApp.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({super.key, required this.name, required this.address, required this.Post_list});
  final List<Post> Post_list;
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
                      padding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                      child: Text(
                        widget.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(52, 0, 0, 0),
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
              // Image.network(
              //   'https://web.ncku.edu.tw/var/file/0/1000/img/495849468.jpg',
              //   fit: BoxFit.cover,
              // ),
              // title: Text(
              //   widget.name,
              //   style: TextStyle(
              //     color: Colors.white,
              //     ),
              //   ),
              // centerTitle: true,
            ),
            //title: Text('My App Bar'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Icon(Icons.arrow_back),
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
        // print(widget.Post_list.length);
        return RawMaterialButton(
          onPressed: () {},
          child: Container(
            // color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: Card(
              child: Image.network(
                  widget.Post_list[index].pictures,
                  fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}
