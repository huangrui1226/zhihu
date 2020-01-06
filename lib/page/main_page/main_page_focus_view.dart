import 'dart:math';

import 'package:flutter/material.dart';

class MainPageFocusView extends StatefulWidget {
  @override
  _MainPageFocusViewState createState() => _MainPageFocusViewState();
}

class _MainPageFocusViewState extends State<MainPageFocusView> {
  List<_FocusModel> modelList = _FocusModel.test(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEFEFEF),
      child: ListView(
        children: List.generate(10, (i) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8),
            child: _CellView(model: modelList[i],),
          );
        }),
      ),
    );
  }
}

class _CellView extends StatelessWidget {
  final _FocusModel model;

  _CellView({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _userView(),
          Container(
            child: Text(model.title),
          ),
          Container(
            child: Text(model.subTitle),
          ),
          _infoView(),
        ],
      ),
    );
  }

  Widget _userView() {
    return Container(
      child: Row(
        children: <Widget>[
          // 头像
          Container(
            width: 32,
            height: 32,
            color: Colors.red,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(model.username),
                ),
                Container(
                  child: Text(model.lastGreatTime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoView() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 16,
            height: 16,
            color: Colors.red,
          ),
          Container(
            child: Text(model.greatCount.toString()),
          ),
          Container(
            width: 16,
            height: 16,
            color: Colors.red,
          ),
          Container(
            child: Text(model.discussCount.toString()),
          ),
        ],
      ),
    );
  }
}

class _FocusModel {
  String iconUrl;
  String username;
  String lastGreatTime;
  String title;
  String subTitle;
  int greatCount;
  int discussCount;

  _FocusModel({
    this.iconUrl,
    this.username,
    this.lastGreatTime,
    this.title,
    this.subTitle,
    this.greatCount,
    this.discussCount,
});

  _FocusModel.fromJson(Map<String, dynamic> json) {
    iconUrl = json['iconUrl'];
    username = json['username'];
    lastGreatTime = json['lastGreatTime'];
    title = json['title'];
    subTitle = json['subTitle'];
    greatCount = json['greatCount'];
    discussCount = json['discussCount'];
  }

  Map<String, dynamic> toJson() {
    Map map = {};
    map['iconUrl'] = iconUrl;
    map['username'] = username;
    map['lastGreatTime'] = lastGreatTime;
    map['title'] = title;
    map['subTitle'] = subTitle;
    map['greatCount'] = greatCount;
    map['discussCount'] = discussCount;
    return map;
  }

  static List<_FocusModel> test(int count) {
    return List.generate(count, (i) {
      return _FocusModel(
        iconUrl: '',
        username: '用户',
        lastGreatTime: '刚刚',
        title: '随机标题',
        subTitle: '随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题',
        greatCount: Random().nextInt(9999),
        discussCount: Random().nextInt(99999),
      );
    });
  }
}
