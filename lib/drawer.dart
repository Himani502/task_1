import 'package:flutter/material.dart';
import 'package:task_1/main.dart';
import 'package:task_1/photospage.dart';
import 'package:task_1/postspage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';
import 'home.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var profileImage;
  bool _checkLoaded = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailId = prefs.getString('email')??'';
      profile = prefs.getString('profile')??'';
      print("emailId");
      print(emailId);
      print(profile);
      profileImage = new NetworkImage(profile);
      profileImage.resolve(new ImageConfiguration()).addListener(new ImageStreamListener((_, __)  {
        if (mounted) {
          setState(() {
            _checkLoaded = false;
          });
        }
      }));
    });
    print("App Drawer initplatform");
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child:new ListView(
        children: <Widget>[
          new Container(
            height: 170.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  appStartColor,
                  appEndColor,
                ],
              ),
            ),
            child: new DrawerHeader(
              child:Column(
                children: <Widget>[
                  new GestureDetector(
                    onTap: (){
                      PhotoView(
                        imageProvider: profileImage,
                      );
                    },
                    child: Container(
                        width: 85.0,
                        height: 85.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: _checkLoaded ? AssetImage('assets/default.png') : profileImage,
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(emailId,style: new TextStyle(fontSize: 18.0,color: Colors.white)),
                ],
              ),
            ),
          ),

          new ListTile(
            title: Row(
              children: <Widget>[
                ImageIcon(
                  AssetImage('assets/Mask-Group-17.png'),
                ),
                SizedBox(width: 15.0,),
                new Text('Home', style: new TextStyle(fontSize: 15.0)),
              ],
            ),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),

          new ListTile(
            title: Row(
              children: <Widget>[
                ImageIcon(
                  AssetImage('assets/Mask-Group-19.png'),
                ),
                SizedBox(width: 15.0,),
                new Text('Photos', style: new TextStyle(fontSize: 15.0)),
              ],
            ),
            onTap:() {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhotosPage()),
              );
            },
          ),

          new ListTile(
            title: Row(
              children: <Widget>[
                ImageIcon(
                  AssetImage('assets/Mask-Group-18.png'),
                ),
                SizedBox(width: 15.0,),
                new Text('Posts', style: new TextStyle(fontSize: 15.0)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostsPage()),
              );
            },
          ),

          new ListTile(
            title: Row(
              children: <Widget>[
                ImageIcon(
                  AssetImage('assets/Mask-Group-22.png'),
                ),
                SizedBox(width: 15.0,),
                new Text("Log out", style: new TextStyle(fontSize: 15.0)),
              ],
            ),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('email');
    prefs.remove('profile');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()), (Route<dynamic> route) => false,
    );
  }

}