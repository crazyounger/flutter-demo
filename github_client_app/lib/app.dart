import 'package:flutter/material.dart';
import 'package:github_client_app/views/home.dart';

class MyApp extends StatefulWidget{

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter App',
      theme: new ThemeData(
        primaryColor: Colors.blueAccent[500],
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          body1: TextStyle(color: Color(0xFF888888),fontSize: 16.0)
        ),
        iconTheme: IconThemeData(
          color: Colors.red[300],
          size: 35.0
        )
      ),
      home: new Scaffold(body: _showAppPage()),
      debugShowCheckedModeBanner: false,

    );
  }

  Widget _showAppPage(){
    return AppPage();
  }


}


void main() async{
  runApp(MyApp());
}