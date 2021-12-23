import 'package:flutter/material.dart';
import 'package:task_1/global.dart';
import 'package:task_1/imageview.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: Image.asset('assets/Menu-Icon-4.png',height: 20.0, width: 20.0, color: Colors.blue[800],),
        tooltip: 'Menu',
        onPressed: (){
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      actions: [
        IconButton(
          icon: Image.asset('assets/Mask-Group-1.png',height: 20.0, width: 20.0, color: Colors.black,),
          tooltip: 'Search',
        ),
        Padding(
          padding: const EdgeInsets.only(right:10.0,left:5.0),
          child: GestureDetector(
            child: Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(profileurl)
                    )
                )
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (
                          context) =>
                          ImageView(
                            myImage: profileurl
                          )));
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(80.0);

}