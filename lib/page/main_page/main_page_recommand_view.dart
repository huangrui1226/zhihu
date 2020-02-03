import 'dart:math';

import 'package:flutter/material.dart';

class MainPageRecmndView extends StatefulWidget {
  @override
  _MainPageRecmndViewState createState() => _MainPageRecmndViewState();
}

class _MainPageRecmndViewState extends State<MainPageRecmndView> {
  List<_RecommandModel> modelList = _RecommandModel.test(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEFEFEF),
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
  final _RecommandModel model;

  _CellView({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.5, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          _userView(),
          Container(
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
              width: 20,
              height: 20,
              child: Image.asset('assets/images/user_icon/example_user_logo.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 9),
            child: Text(
              model.username,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                model.userSign,
                style: TextStyle(color: Colors.black38, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoView() {
    return Container(
      margin: EdgeInsets.only(left: 2, top: 8),
      child: Text(
        '${model.greatCount} 赞同 - ${model.discussCount} 评论',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _RecommandModel {
  String title;
  String iconUrl;
  String username;
  String userSign;
  String subTitle;
  int greatCount;
  int discussCount;

  _RecommandModel({
    this.title,
    this.iconUrl,
    this.username,
    this.userSign,
    this.subTitle,
    this.greatCount,
    this.discussCount,
  });

  _RecommandModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    iconUrl = json['iconUrl'];
    username = json['username'];
    userSign = json['userSign'];
    subTitle = json['subTitle'];
    greatCount = json['greatCount'];
    discussCount = json['discussCount'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['title'] = 'title';
    map['iconUrl'] = 'iconUrl';
    map['username'] = 'username';
    map['userSign'] = 'userSign';
    map['subTitle'] = 'subTitle';
    map['greatCount'] = 'greatCount';
    map['discussCount'] = 'discussCount';
    return map;
  }

  static List<_RecommandModel> test(int count) {
    return List.generate(count, (i) {
      return _RecommandModel(
        title: '苹果11不小心隔夜充了九个多小时会有什么危害吗？',
        iconUrl: '',
        username: '一颗刺猬',
        userSign: '',
        subTitle:
            '千万别这样充电！！！危害特别大！！要知道充九个多小时早上起来电池肯定...',
        greatCount: Random().nextInt(9999),
        discussCount: Random().nextInt(99999),
      );
    });
  }
}
