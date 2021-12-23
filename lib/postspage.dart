import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_1/appbar.dart';
import 'package:task_1/bottomnavigationbar.dart';
import 'package:task_1/drawer.dart';

class PostsPage extends StatefulWidget {
  //const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: Container(
          child: Text("PostsPage"),
        ),
      ),
    );
  }
}
