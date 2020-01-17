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
            child: _RecommandCell(model: modelList[i],),
          );
        }),
      ),
    );
  }
}

class _RecommandCell extends StatelessWidget {
  final _RecommandModel model;

  _RecommandCell({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(model.title),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.red,
                ),
                Text(model.userSign),
              ],
            ),
          ),
          Container(
            child: Text(model.subTitle),
          ),
          Container(
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
                  child: Text('•'),
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
          ),
        ],
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
        title: '随机标题',
        iconUrl: '',
        username: '用户',
        userSign: '用户个性签名',
        subTitle: '随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题随机副标题',
        greatCount: Random().nextInt(9999),
        discussCount: Random().nextInt(99999),
      );
    });
  }

}