import 'package:flutter/material.dart';
import 'package:task_1/appbar.dart';
import 'package:task_1/drawer.dart';
import 'package:photo_view/photo_view.dart';

void main() => runApp(new ImageView());

class ImageView extends StatefulWidget {
  final String myImage;
  ImageView({this.myImage});
  @override
  _ImageView createState() => _ImageView();

}

class _ImageView extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppHeader(),
        drawer: AppDrawer(),
        body: Center(
          child:Container(
              child: PhotoView(
                imageProvider: NetworkImage(widget.myImage),
              )
          ),
        ),
      ),
    );
  }

}