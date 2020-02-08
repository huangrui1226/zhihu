import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double _margin = 15;

class MemberRecommandView extends StatefulWidget {
  @override
  _MemberRecommandViewState createState() => _MemberRecommandViewState();
}

class _MemberRecommandViewState extends State<MemberRecommandView> {
  List<_CategoryModel> modelList;
  List<_BookModel> myBookshelfList;

  @override
  void initState() {
    modelList = _CategoryModel.test();
    myBookshelfList = _BookModel.test();
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
          _MyBookshelf(bookList: myBookshelfList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
        ],
      ),
    );
  }
}

class _BannerView extends StatefulWidget {
  @override
  __BannerViewState createState() => __BannerViewState();
}

class __BannerViewState extends State<_BannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: _margin, left: _margin, right: _margin),
      child: AspectRatio(
        aspectRatio: 768 / 200.0,
        child: Image.asset('assets/images/member/member_recommand/banner_view.png'),
      ),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final List<_CategoryModel> modelList;

  _CategoryView(
    this.modelList, {
    Key key,
  }) : super(key: key);

  @override
  __CategoryViewState createState() => __CategoryViewState();
}

class __CategoryViewState extends State<_CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_margin),
      child: Row(
          children: List.generate(widget.modelList.length, (index) {
        _CategoryModel model = widget.modelList[index];
        return _cellView(model);
      })),
    );
  }

  Widget _cellView(_CategoryModel model) {
    double length = (MediaQuery.of(context).size.width - _margin * 6) / 5;
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

class _MyBookshelf extends StatefulWidget {
  final List<_BookModel> bookList;

  _MyBookshelf({
    Key key,
    this.bookList = const [],
  }) : super(key: key);

  @override
  __MyBookshelfState createState() => __MyBookshelfState();
}

class __MyBookshelfState extends State<_MyBookshelf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('我的书架', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('前往书架', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            height: 234,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: List.generate(widget.bookList.length, (index) {
                _BookModel model = widget.bookList[index];
                return _cellView(model);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellView(_BookModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 118,
            height: 158,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(model.imagePath, fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 228, 234),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Text(
                      model.isDigit ? '电子书' : '实体书',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(model.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(model.subTitle, style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
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
    String base = 'assets/images/member/member_recommand/';
    return [
      _CategoryModel(
        title: '每日上新',
        imagePath: base + 'member_recommand_category_0.png',
      ),
      _CategoryModel(
        title: '榜单',
        imagePath: base + 'member_recommand_category_1.png',
      ),
      _CategoryModel(
        title: '小说',
        imagePath: base + 'member_recommand_category_2.png',
      ),
      _CategoryModel(
        title: '免费专区',
        imagePath: base + 'member_recommand_category_3.png',
      ),
      _CategoryModel(
        title: '分类',
        imagePath: base + 'member_recommand_category_4.png',
      ),
    ];
  }
}

class _BookModel {
  String imagePath;
  bool isDigit; // 电子书/实体书
  String title;
  String subTitle;

  _BookModel({
    this.imagePath,
    this.isDigit,
    this.title,
    this.subTitle,
  });

  _BookModel.fromJson(Map json) {
    imagePath = json['imagePath'];
    isDigit = json['isDigit'];
    title = json['title'];
    subTitle = json['subTitle'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['imagePath'] = imagePath;
    json['isDigit'] = isDigit;
    json['title'] = title;
    json['subTitle'] = subTitle;
    return json;
  }

  static List<_BookModel> test() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _BookModel(
        imagePath: base + 'book_image_0.png',
        isDigit: true,
        title: '魔法外套',
        subTitle: '尚未阅读',
      ),
    ];
  }
}
