import 'package:flutter_farmtofabric/view/create_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_farmtofabric/view/create_blog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  QuerySnapshot blogsSnapshot;

  Widget BlogList() {
    return Container(
      child: Column(
        children: <Widget>[ListView.builder(itemBuilder: null)],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      blogsSnapshot = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Flutter", style: TextStyle(fontSize: 22)),
                Text(
                  "Farm2Fabric_learn",
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                )
              ]),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBlog()));
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ));
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile({super.key});
  String imgUrl, title, descripton, authorName;
  BlogsTile(
    {@required this.imgUrl,
    @required this.title,
    @required this.descriptor,
    @required this.authorName})

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
     borderRadius:  BorderRadius.circular(6),
     child: Image.network(imgUrl),
    Container(
      height: 150,
    decoration: BoxDecoration,(
      color: Colors.black45.WithOpacity(0.3),
      borderRadius:  BorderRadius.circular(6)),
    ),
    Container(child: Column(children: <Widget>[
      Text(title),
      Text(description),
      Text(authorName)
    ],))
    )]));
  }
}
