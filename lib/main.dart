import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhihu/main_tabbar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MainTabPage.rName,
      routes: {
        MainTabPage.rName : (context) => MainTabPage(),
      },
    );
  }
}
