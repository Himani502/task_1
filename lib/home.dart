import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_1/appbar.dart';
import 'package:task_1/bottomnavigationbar.dart';
import 'package:task_1/drawer.dart';
import 'package:task_1/global.dart';
import 'package:task_1/imageview.dart';
import 'package:task_1/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url='https://images.unsplash.com/photo-1522717425499-89d3198ccc74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60';
  var url1='https://cdn.wealthygorilla.com/wp-content/uploads/2015/06/Top-10-Most-Inspirational-Short-Stories-Ive-Heard.jpg';


  @override
  void initState() {
    super.initState();
    initplatformstate();
  }

  initplatformstate() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Featured Article", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),
          ),
          SizedBox(height: 20.0,),
          getWidget(),
          SizedBox(height: 5.0,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Featured Videos", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),
          ),
          SizedBox(height: 20.0,),
          getWidget1()
        ],
      )
    );
  }

  Widget getWidget(){
    return Expanded(
      flex: 2,
      child: FutureBuilder<List<Photos>>(
        future: getPhotos(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length>0){
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Card(
                        margin: EdgeInsets.only(left: 15.0, bottom: 50),
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), //<--custom shape
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                              child: InkWell(
                                child: Image.asset(
                                  'assets/photo-1491975474562-1f4e30bc9468.jpg',
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  fit: BoxFit.cover,
                                ),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (
                                      context) =>
                                      ImageView(
                                          myImage: snapshot
                                              .data[index]
                                              .url,
                                      )));
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                                  gradient: LinearGradient(
                                    colors: [appStartColor, appEndColor],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data[index].title, style: TextStyle(color: Colors.white), maxLines: 2,),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("READ NOW", style: TextStyle(color: Colors.white)),
                                          SizedBox(width: 10.0,),
                                          Container(
                                            width: 35.0,
                                            height: 35.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: IconButton(
                                              icon: Image.asset('assets/Fav-Star.png',height: 40.0, width: 40.0, color: Colors.grey,),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget getWidget1(){
    return Expanded(
      child: FutureBuilder<List<Photos>>(
        future: getPosts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length>0){
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: Card(
                        margin: EdgeInsets.only(left: 15.0, bottom: 24),
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), //<--custom shape
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/istockphoto-1317784594-170667a.jpg',
                                width: MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fill,
                                color: Colors.black,
                                colorBlendMode: BlendMode.softLight
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ImageIcon(
                                AssetImage('assets/Mask-Group-18.png'),
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35.0,
                                      height: 35.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        icon: Image.asset('assets/Fav-Star.png',height: 40.0, width: 40.0, color: Colors.grey,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

