import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPageHotView extends StatefulWidget {
  @override
  _MainPageHotViewState createState() => _MainPageHotViewState();
}

class _MainPageHotViewState extends State<MainPageHotView> {
  List<_HotModel> modelList;
  List<_CategoryModel> categoryList;

  @override
  void initState() {
    modelList = _HotModel.test();
    categoryList = _CategoryModel.test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEFEFEF),
      child: Column(
        children: <Widget>[
          _CategoryView(list: categoryList),
          Expanded(
            child: ListView(
              children: List.generate(10, (i) {
                return Container(
                  color: Colors.white,
                  child: _CellView(
                    model: modelList[i],
                    index: i,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _CellView extends StatelessWidget {
  final _HotModel model;
  final int index;

  _CellView({
    this.model,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 15,
                    height: 19,
                    color: () {
                      if (index == 0) {
                        return Color(0xFFF55651);
                      } else if (index == 1) {
                        return Color(0xFFFE8D03);
                      } else if (index == 2) {
                        return Color(0xFFECB36E);
                      } else {
                        return Colors.white;
                      }
                    }(),
                    margin: EdgeInsets.only(right: 12, top: 2),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: index > 2 ? Colors.black54 : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              model.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          () {
                            if (model.subTitle == '') {
                              return Container();
                            } else {
                              return Text(
                                model.subTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              );
                            }
                          }(),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              model.detail,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    width: 95,
                    height: 66,
                    child: Image.asset('assets/images/main_hot/main_hot_pic_$index.png'),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Color(0xFFD2D2D2)),
          ],
        ),
      ),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final List<_CategoryModel> list;

  _CategoryView({Key key, this.list}) : super(key: key);

  @override
  __CategoryViewState createState() => __CategoryViewState();
}

class __CategoryViewState extends State<_CategoryView> {
  int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 53,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.list.length, (i) {
          _CategoryModel model = widget.list[i];
          return GestureDetector(
            onTap: () {
              setState(() {
                index = i;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: i == index ? Color(0xFFEAF5FF) : Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Center(
                child: Text(
                  model.title,
                  style: TextStyle(
                    color: i == index ? Color(0xFF0084FE) : Color(0xFF808080),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _HotModel {
  String title;
  String subTitle;
  String detail;
  String imageUrl;

  _HotModel({
    this.title,
    this.subTitle,
    this.detail,
    this.imageUrl,
  });

  _HotModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    detail = json['detail'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['title'] = title;
    json['subTitle'] = subTitle;
    json['detail'] = detail;
    json['imageUrl'] = imageUrl;
    return json;
  }

  static List<_HotModel> test() {
    return [
      _HotModel(
        title: '全国心性肺炎情况怎么样了',
        subTitle: '了解疫情最新进展>>',
        detail: '置顶',
        imageUrl: '',
      ),
      _HotModel(
        title: '为什么说「新型冠状病毒是人造的」不靠谱？',
        subTitle: '',
        detail: '5261 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '有那些是减肥后的翻车现场？',
        subTitle: '很多人都说减完肥就变漂亮变帅，但我相信也不是每个人都会有这种神奇的变化。这种减肥',
        detail: '4453 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '内蒙古出现特殊病例：无外出无接触，但住患者楼上，可能是通过哪些途径感染的？',
        subTitle: '',
        detail: '4427 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '如何看待趁主人被隔离观察，社区将其宠物猫活埋？主人该如何维权？',
        subTitle: '',
        detail: '4415 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '美国首例新冠病毒患者使用未获批药瑞德西韦后大幅好转，它有望成为病毒克星吗？',
        subTitle: '',
        detail: '4404 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '2020 年 2 月 2 日是千年对称日，这一天可以做什么纪念性的活动呢？',
        subTitle: '',
        detail: '2780 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '2 月 1 日全国新型肺炎累计确诊 14380 例，死亡 304 例，目前防治情况怎么样了？',
        subTitle: '',
        detail: '2779 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '如何看待国外亿万富翁无人脉 90 天重新用 100 美元赚到75w？',
        subTitle: '',
        detail: '2070 万热度',
        imageUrl: '',
      ),
      _HotModel(
        title: '5 岁女孩商场撒泼打滚，父亲静看 3 小时，如果你是父亲有什么好办法？',
        subTitle: '',
        detail: '1824 万热度',
        imageUrl: '',
      ),
    ];
  }
}

class _CategoryModel {
  String title;

  _CategoryModel({this.title});

  _CategoryModel.fromJson(Map json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['title'] = title;
    return json;
  }

  static List<_CategoryModel> test() {
    return [
      _CategoryModel(title: '全站'),
      _CategoryModel(title: '科学'),
      _CategoryModel(title: '数码'),
      _CategoryModel(title: '体育'),
      _CategoryModel(title: '时尚'),
      _CategoryModel(title: '影院'),
      _CategoryModel(title: '汽车'),
    ];
  }
}
