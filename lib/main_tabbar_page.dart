import 'package:flutter/material.dart';
import 'package:zhihu/member_page.dart';
import 'package:zhihu/page/main_page/main_page.dart';
import 'package:zhihu/message_page.dart';
import 'package:zhihu/mine_page.dart';

class MainTabPage extends StatefulWidget {
  static String rName = 'MainTabPage';

  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  MainPage _mainPage;
  MemberPage _memberPage;
  MessagePage _messagePage;
  MinePage _minePage;
  List<Widget> _pageList;
  int _currentIndex = 0;

  @override
  void initState() {
    _mainPage = MainPage();
    _memberPage = MemberPage();
    _messagePage = MessagePage();
    _minePage = MinePage();

    _pageList = [
      _mainPage,
      _memberPage,
      _messagePage,
      _minePage,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('会员'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('消息'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('我的'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
