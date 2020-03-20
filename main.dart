import 'package:flutter/material.dart';
import 'package:upload_image/app.dart';
void main()=>runApp(
  MaterialApp(
    title:"SQflite App",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData(
      primaryColor:Colors.pink,
    ),
  )
);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(title: "SQflite App"),
    );
  }
}