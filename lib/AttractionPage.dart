import 'package:flutter/material.dart';
import 'PetApp.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({super.key, required this.Post_list});
  final List<Post> Post_list;

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
            backgroundColor: Colors.green,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://web.ncku.edu.tw/var/file/0/1000/img/495849468.jpg',
                fit: BoxFit.cover,
              ),
              title: Text(
                '榕園',
                style: TextStyle(
                  color: Colors.white,
                  ),
                ),
              centerTitle: true,
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
              child: Image.asset(
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
