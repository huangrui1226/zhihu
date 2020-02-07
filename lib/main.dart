import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zhihu/main_tabbar_page.dart';

import 'package:zhihu/page/main_page/direct_seed/direct_seed_page.dart';
import 'package:zhihu/page/main_page/search_view/main_search_page.dart';
import 'package:zhihu/page/member_page/member_page.dart';

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
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          textTheme: Typography().black,
        ),
      ),
      initialRoute: MainTabPage.rName,
      routes: {
        MainTabPage.rName: (context) => MainTabPage(),
        MainSearchPage.rName: (context) => MainSearchPage(),
        DirectSeedPage.rName: (context) => DirectSeedPage(),
        MemberPage.rName: (context) => MemberPage(),
      },
    );
  }
}
