import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'global.dart';
import 'home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showError=false;
  bool _isServiceCalling = false;
  TextEditingController firstNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  void initState() {
    // TODO: implement initState
    initPlatformState();

    super.initState();
  }

  void initPlatformState() async{
    var prefs=await SharedPreferences.getInstance();
    var isLoggedIn=prefs.getString("loggedIn")??"No" ;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome',
                        style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),),
                      SizedBox(height: 40,),
                      SvgPicture.asset('assets/icons/signup.svg'
                      ),
                      /*Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/icons/chat.jpg",
                          width: 280.0,
                        ),
                         // child: AssetImage("assets/icons/chat.jpg"),
                      ),*/
                      SizedBox(height: 40,),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                        // width:size.width *0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFF1E6FF),
                        ),
                        child: TextField(
                          controller: firstNameController,
                          cursorColor: Color(0xFF6F35A5),
                          decoration: InputDecoration(
                            icon: Icon(Icons.mail_rounded,
                              color: Color(0xFF6F35A5),),
                            //   backgroundColor: Color(0xFF5C6BC0),),
                            hintText: 'UserName',
                            border: InputBorder.none,
                          ),
                        ),


                      ), showError?Text("first name should have 6 characters",
                        style: TextStyle(color: Colors.black),) : Container(),
                      SizedBox(height: 5,),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                        // width:size.width *0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFF1E6FF),
                        ),
                        child: TextField(
                          controller: passwordController,
                          cursorColor: Color(0xFF6F35A5),
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock,
                              color: Color(0xFF6F35A5),),
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () async {
                          String email=firstNameController.text;
                          String password=passwordController.text;
                          var lengthOfName = firstNameController.text.length;
                          checkLogin(firstNameController.text.trim(),passwordController.text.trim(),);


                        },
                        borderRadius: BorderRadius.circular(30),
                        child:Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF6F35A5),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15,),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
  checkLogin(String username, String password){
    setState(() {
      _isServiceCalling = true;
    });
    var url = "https://reqres.in/api/login";
    http.post(Uri.parse(url), body: {
      "email": username,
      "password": password,
    }).then((response) async {
      print(response.body.toString());
      Map data = json.decode(response.body);
      print("data");
      if(data["token"]=="QpwL5tke4Pnpja7X4"){
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", data["token"]);
        prefs.setString("email", username);
        prefs.setString("profile", profileurl);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), (
            Route<dynamic> route) => false,
        );
      }else{
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context);
              });
              return AlertDialog(
                content: new Text("User not found"),
              );
            });
      }
      setState(() {
        _isServiceCalling = false;
      });
    }).catchError((exp){
      print(exp);
      setState(() {
        _isServiceCalling=false;
      });
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pop(context);
            });
            return AlertDialog(
              content: new Text("Exception generated"),
            );
          });
    });
  }
}

