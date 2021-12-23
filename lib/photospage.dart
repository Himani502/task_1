import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_1/appbar.dart';
import 'package:task_1/bottomnavigationbar.dart';
import 'package:task_1/drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhotosPage extends StatefulWidget {
  //const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(),
      body: Center(
        child: Container(
          child: Text("PhotosPage"),
        ),
      ),
    );
  }
}
