import 'package:flutter/material.dart';
import 'package:task_1/home.dart';
import 'package:task_1/photospage.dart';
import 'package:task_1/postspage.dart';

class BottomNavigation extends StatefulWidget {
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/Mask-Group-17.png'),
          ),
          label: "Home",
          /*icon: SvgPicture.asset(assetName),
            label: "Home",*/
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/Mask-Group-19.png')
          ),
          label: "Photos",
          /*icon: SvgPicture.asset(assetName1),
            label: "Home",*/
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/Mask-Group-18.png')
          ),
          label: "Posts",
          /*icon: SvgPicture.asset(assetName2),
            label: "Home",*/
        ),
      ],

      onTap: (newIndex) {
        setState(() {
          _currentIndex = newIndex;
          print("_currentIndex");
          print(_currentIndex);
        });
        if (newIndex == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          return;
        } else if (newIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PhotosPage()),
          );
          return;
        }else if (newIndex == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostsPage()),
          );
          return;
        }
      },
    );
  }
}