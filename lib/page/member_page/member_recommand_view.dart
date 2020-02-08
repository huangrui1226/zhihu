import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double _margin = 20.0;

class MemberRecommandView extends StatefulWidget {
  @override
  _MemberRecommandViewState createState() => _MemberRecommandViewState();
}

class _MemberRecommandViewState extends State<MemberRecommandView> {
  List<_CategoryModel> modelList;
  List<_BookModel> myBookshelfList;
  List<_LecturesModel> recommandList;
  List<_DiscountModel> discountList;

  @override
  void initState() {
    modelList = _CategoryModel.test();
    myBookshelfList = _BookModel.test();
    recommandList = _LecturesModel.test();
    discountList = _DiscountModel.test();
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
          _HotRecommandView(recommandList: recommandList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
          _DiscountTodayView(modelList: discountList),
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
        child: Image.asset('assets/images/member/member_recommand/banner_view.png'),
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

class _MyBookshelf extends StatelessWidget {
  final List<_BookModel> bookList;

  _MyBookshelf({
    Key key,
    this.bookList = const [],
  }) : super(key: key);

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
              children: List.generate(bookList.length, (index) {
                _BookModel model = bookList[index];
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

class _HotRecommandView extends StatelessWidget {
  final List<_LecturesModel> recommandList;

  _HotRecommandView({
    this.recommandList = const [],
    Key key,
  }) : super(key: key);

  final double margin = 15;
  final double space = 10;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - _margin * 2 - 10) / 2;
    double height = width / (182 / 100.0) + 80;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _margin),
      child: Column(
        children: <Widget>[
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('热门推荐', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            height: height,
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: height / width,
              ),
              children: List.generate(4, (index) {
                _LecturesModel model = recommandList[index];
                return _cellView(model);
              }),
            ),
          ),
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('有哪些真是的职业故事？', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: height * 2 + 10,
            child: GridView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: width / height,
              ),
              children: List.generate(4, (index) {
                _LecturesModel model = recommandList[index + 4];
                return _cellView(model);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellView(_LecturesModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: AspectRatio(
              aspectRatio: 182 / 100.0,
              child: Image.asset(model.imagePath),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text(
              model.title,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              '${model.numberOfArticle} 篇',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscountTodayView extends StatelessWidget {
  final List<_DiscountModel> modelList;

  _DiscountTodayView({
    Key key,
    this.modelList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cellMargin = 10.0;
    double ratio = 364 / 538.0;
    double width = (MediaQuery.of(context).size.width - _margin * 2 - cellMargin) / 2;
    double height = width / ratio;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _margin, vertical: 16),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '今日限免 & 折扣',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            '点击订阅，第一时间获取免费 & 特价好内容',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 72,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(246, 247, 248, 1.0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      '订阅',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 132, 254),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height,
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: cellMargin,
                mainAxisSpacing: cellMargin,
                childAspectRatio: 1.0 / ratio,
              ),
              children: List.generate(modelList.length, (index) {
                _DiscountModel model = modelList[index];
                return _cellView(model);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellView(_DiscountModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Expanded(flex: 40, child: Container()),
                Expanded(
                  flex: 254,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 87, child: Container()),
                        Expanded(
                          flex: 190,
                          child: AspectRatio(
                            aspectRatio: 190 / 254.0,
                            child: Image.asset(model.image),
                          ),
                        ),
                        Expanded(flex: 87, child: Container()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 244,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            model.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            '原价：¥${model.originalPrice}',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 251, 152, 12), width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            model.currentPrice == 0 ? '免费领取' : '${model.currentPrice} 元领取',
                            style: TextStyle(
                              color: Color.fromARGB(255, 251, 152, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(),
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

class _LecturesModel {
  String imagePath; // 盐选的封面
  String title; // 盐选的名称
  int numberOfArticle; // 盐选的文章数

  _LecturesModel({
    this.imagePath,
    this.title,
    this.numberOfArticle,
  });

  _LecturesModel.fromJson(Map json) {
    imagePath = json['imagePath'];
    title = json['title'];
    numberOfArticle = json['numberOfArticle'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['imagePath'] = imagePath;
    json['title'] = title;
    json['numberOfArticle'] = numberOfArticle;
    return json;
  }

  static List<_LecturesModel> test() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _LecturesModel(
        imagePath: base + 'lecture_image_0.png',
        title: '巷说异闻录：细思恐极的民间传说',
        numberOfArticle: 8,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_1.png',
        title: '真实人间：8个农村老家的故事',
        numberOfArticle: 8,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_2.png',
        title: '非典纪实：瘟疫与人类的生存战',
        numberOfArticle: 23,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_3.png',
        title: '实习医生成长手记：我与患者的第一年',
        numberOfArticle: 12,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_4.png',
        title: '罪恶拼图：永远不要考验人性',
        numberOfArticle: 7,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_5.png',
        title: '十九夜：夜夜有直击人性阴暗面的故事等着你',
        numberOfArticle: 19,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_6.png',
        title: '大都会暗黑时间簿：李淼带你看城市深处的杀人案',
        numberOfArticle: 5,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_5.png',
        title: '逃离金三角：在缅甸当司机的 397 天',
        numberOfArticle: 10,
      ),
    ];
  }
}

class _DiscountModel {
  String image;
  String title;
  double originalPrice;
  double currentPrice;

  _DiscountModel({
    this.image,
    this.title,
    this.originalPrice,
    this.currentPrice,
  });

  _DiscountModel.fromJson(Map json) {
    image = json['image'];
    title = json['title'];
    originalPrice = json['originalPrice'];
    currentPrice = json['currentPrice'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['image'] = image;
    json['title'] = title;
    json['originalPrice'] = originalPrice;
    json['currentPrice'] = currentPrice;
    return json;
  }

  static List<_DiscountModel> test() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _DiscountModel(
        image: base + 'discount_image_0.png',
        title: '人类的误测',
        originalPrice: 9.99,
        currentPrice: 0.0,
      ),
      _DiscountModel(
        image: base + 'discount_image_1.png',
        title: '高效人士用超级笔记术',
        originalPrice: 17.99,
        currentPrice: 7.99,
      ),
      _DiscountModel(
        image: base + 'discount_image_2.png',
        title: '大学生如何培养独立思考的能力？',
        originalPrice: 19.9,
        currentPrice: 0.0,
      ),
      _DiscountModel(
        image: base + 'discount_image_3.png',
        title: '这本书能让你睡得好',
        originalPrice: 17.99,
        currentPrice: 7.99,
      ),
    ];
  }
}
