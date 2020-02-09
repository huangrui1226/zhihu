import 'package:flutter/material.dart';

double _margin = 20.0;

class MemberReadingView extends StatefulWidget {
  static String rName = 'MemberReadingView';

  @override
  _MemberReadingViewState createState() => _MemberReadingViewState();
}

class _MemberReadingViewState extends State<MemberReadingView> {
  List<_CategoryModel> modelList;

  @override
  void initState() {
    modelList = _CategoryModel.test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _BannerView(),
          _CategoryView(modelList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
        ],
      ),
    );
  }
}

class _BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double margin = 15.0;
    return Container(
      padding: EdgeInsets.only(top: margin, left: margin, right: margin),
      child: AspectRatio(
        aspectRatio: 768 / 200.0,
        child: Image.asset('assets/images/member/member_reading/banner_view.png'),
      ),
    );
  }
}

class _CategoryView extends StatelessWidget {
  final List<_CategoryModel> modelList;

  _CategoryView(
      this.modelList, {
        Key key,
      }) : super(key: key);

  BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    rootContext = context;
    return Container(
      margin: EdgeInsets.all(_margin),
      child: Row(
          children: List.generate(modelList.length, (index) {
            _CategoryModel model = modelList[index];
            return _cellView(model);
          })),
    );
  }

  Widget _cellView(_CategoryModel model) {
    double length = (MediaQuery.of(rootContext).size.width - _margin * 6) / 5;
    return Expanded(
      flex: 1,
      child: Container(
        width: length,
        child: Column(
          children: [
            Container(
              width: 35,
              height: 35,
              child: Image.asset(model.imagePath),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                model.title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryModel {
  String imagePath;
  String title;

  _CategoryModel({
    this.imagePath,
    this.title,
  });

  _CategoryModel.fromJson(Map json) {
    imagePath = json['imagePath'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    Map map = Map();
    map['title'] = title;
    map['imagePath'] = imagePath;
    return map;
  }

  static List<_CategoryModel> test() {
    String base = 'assets/images/member/member_reading/';
    return [
      _CategoryModel(
        title: '知乎出品',
        imagePath: base + 'member_reading_category_0.png',
      ),
      _CategoryModel(
        title: '书榜',
        imagePath: base + 'member_reading_category_1.png',
      ),
      _CategoryModel(
        title: '小说',
        imagePath: base + 'member_reading_category_2.png',
      ),
      _CategoryModel(
        title: '讲书',
        imagePath: base + 'member_reading_category_3.png',
      ),
      _CategoryModel(
        title: '分类',
        imagePath: base + 'member_reading_category_4.png',
      ),
    ];
  }
}