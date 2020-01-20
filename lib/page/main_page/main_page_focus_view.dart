import 'dart:math';

import 'package:flutter/material.dart';

enum FocusViewType {
  all,        // 全部
  originate,  // 只看原创
  idea,       // 只看想法
}

class MainPageFocusView extends StatefulWidget {
  final FocusViewType type;

  MainPageFocusView({Key key, this.type}) : super(key: key);

  @override
  _MainPageFocusViewState createState() => _MainPageFocusViewState();
}

class _MainPageFocusViewState extends State<MainPageFocusView> {
  List<_FocusModel> modelList = _FocusModel.test(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: ListView(
        children: List.generate(10, (i) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8),
            child: _CellView(
              model: modelList[i],
            ),
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
      padding: EdgeInsets.symmetric(vertical: 15.5, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userView(),
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              model.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Text(
              model.subTitle,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
          _infoView(),
        ],
      ),
    );
  }

  Widget _userView() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          // 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(15.5),
            child: Container(
              margin: EdgeInsets.only(right: 9),
              width: 33,
              height: 33,
              child: Image.asset('assets/images/example_user_logo.png'),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    model.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    model.lastGreatTime,
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
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
      margin: EdgeInsets.only(left: 2),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 6),
            width: 18,
            height: 18,
            child: Image.asset('assets/images/focus_support.png'),
          ),
          Container(
            child: Text(model.greatCount.toString()),
            margin: EdgeInsets.only(right: 32),
          ),
          Container(
            margin: EdgeInsets.only(right: 6),
            width: 18,
            height: 18,
            child: Image.asset('assets/images/focus_discuss.png'),
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
        username: '阿里云云栖号',
        lastGreatTime: '33分钟前·发表了文章',
        title: '共享充电宝竟然是这样管理的，看咻电科技如何在云端管理千万设备',
        subTitle:
            '公司介绍我们公司是咻点科技是国内领先的科技创新型企业，聚焦高新技术研发应用和智慧场景社交。分公司覆盖国内21个省市，市场运营团队共1000+人，独立自处...',
        greatCount: Random().nextInt(9999),
        discussCount: Random().nextInt(99999),
      );
    });
  }
}
