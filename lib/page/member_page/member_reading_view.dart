import 'package:flutter/material.dart';

double _margin = 20.0;

class MemberReadingView extends StatefulWidget {
  static String rName = 'MemberReadingView';

  @override
  _MemberReadingViewState createState() => _MemberReadingViewState();
}

class _MemberReadingViewState extends State<MemberReadingView> {
  List<_CategoryModel> modelList;
  List<_SectionModel> sectionList;
  List<_BookGoodModel> bookList;

  @override
  void initState() {
    modelList = _CategoryModel.test();
    sectionList = _SectionModel.test();
    bookList = _BookGoodModel.test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _BannerView(),
          _CategoryView(modelList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
        ]
          ..addAll(sectionList.map((model) {
            return _SectionView(model: model);
          }))
          ..add(_FindMoreView(modelList: bookList)),
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

class _SectionView extends StatelessWidget {
  final _SectionModel model;

  _SectionView({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = 236 / 482;
    double width = MediaQuery.of(context).size.width - _margin * 2;
    double cellWidth = (width - 10 * 2) / 3;
    double cellHeight = cellWidth / ratio;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: _margin),
            child: Column(
              children: <Widget>[
                Container(
                  height: 61,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: Text(model.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                      Text(model.subTitle, style: TextStyle(color: Colors.black38, fontSize: 13)),
                      Icon(Icons.arrow_right, size: 14),
                    ],
                  ),
                ),
                Container(
                  height: cellHeight + 8,
                  child: GridView(
                    padding: EdgeInsets.only(bottom: 8),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      childAspectRatio: 1 / ratio,
                    ),
                    children: List.generate(model.bookList.length, (index) {
                      _BookModel model = this.model.bookList[index];
                      return _cellView(model);
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(model.imagePath, fit: BoxFit.fill),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text(model.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400), maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(model.subTitle,
                style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class _FindMoreView extends StatelessWidget {
  final List<_BookGoodModel> modelList;

  _FindMoreView({
    Key key,
    this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: _margin),
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('发现更多', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
          ),
        ]..addAll(modelList.map((model) {
            return _cellView(model);
          })),
      ),
    );
  }

  Widget _cellView(_BookGoodModel model) {
    double ratio = 140 / 186.0;
    EdgeInsetsGeometry padding = EdgeInsets.only(bottom: _margin, left: _margin, right: _margin);
    return Container(
      padding: padding,
      height: 113,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: ratio,
            child: Image.asset(
              model.imagePaht,
//              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  Text(
                    model.author,
                    style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    model.subTitle,
                    style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 245, 246, 247),
                  ),
                  child: Center(
                    child: Text(
                      '¥ ${model.price}',
                      style: TextStyle(
                        color: Color.fromRGBO(203, 153, 79, 1.0),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    model.isFree ? '盐选会员免费' : '',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionModel {
  String title;
  String subTitle;
  List<_BookModel> bookList;

  _SectionModel({
    this.title,
    this.subTitle,
    this.bookList = const [],
  });

  _SectionModel.fromJson(Map json) {
    title = json['title'];
    subTitle = json['subTitle'];
    bookList = json['bookList'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    json['subTitle'] = subTitle;
    json['bookList'] = bookList;
    return json;
  }

  static List<_SectionModel> test() {
    return [
      _SectionModel(
        title: '热门推荐',
        subTitle: '查看更多',
        bookList: _BookModel.recommandTest(),
      ),
      _SectionModel(
        title: '为你讲书',
        subTitle: '查看更多',
        bookList: _BookModel.readingForYouTest(),
      ),
      _SectionModel(
        title: '知乎一小时',
        subTitle: '查看更多',
        bookList: _BookModel.oneHourTest(),
      ),
      _SectionModel(
        title: '有哪些精彩的悬疑故事',
        subTitle: '查看更多',
        bookList: _BookModel.suspenseStoryTest(),
      ),
      _SectionModel(
        title: '有哪些相见恨晚的历史好书',
        subTitle: '查看更多',
        bookList: _BookModel.historyBookTest(),
      ),
      _SectionModel(
        title: '有哪些值得一读的影视原著？',
        subTitle: '查看更多',
        bookList: _BookModel.movieBookTest(),
      ),
      _SectionModel(
        title: '惊艳到你的文学作品有哪些？',
        subTitle: '查看更多',
        bookList: _BookModel.expressionBookTest(),
      ),
      _SectionModel(
        title: '如何让经济学为你所用？',
        subTitle: '查看更多',
        bookList: _BookModel.economicBookTest(),
      ),
      _SectionModel(
        title: '如何快速获取互联网干货？',
        subTitle: '查看更多',
        bookList: _BookModel.netBookTest(),
      ),
      _SectionModel(
        title: '你真的会恋爱吗？',
        subTitle: '查看更多',
        bookList: _BookModel.loveBookTest(),
      ),
      _SectionModel(
        title: '你读过哪些治愈系的书？',
        subTitle: '查看更多',
        bookList: _BookModel.cureBookTest(),
      ),
    ];
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

  static List<_BookModel> recommandTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_0.png',
        isDigit: true,
        title: '新型冠状病毒感染的肺炎防护手册',
        subTitle: '鼓楼医院',
      ),
      _BookModel(
        imagePath: base + 'book_image_1.png',
        isDigit: true,
        title: '病毒星球',
        subTitle: '卡尔·齐默',
      ),
      _BookModel(
        imagePath: base + 'book_image_2.png',
        isDigit: true,
        title: '三体（全集）',
        subTitle: '刘慈欣',
      ),
      _BookModel(
        imagePath: base + 'book_image_3.png',
        isDigit: true,
        title: '怪奇事务所',
        subTitle: '怪奇事务所所长',
      ),
    ];
  }

  static List<_BookModel> readingForYouTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_4.png',
        isDigit: true,
        title: '亲密关系',
        subTitle: '杨钒',
      ),
      _BookModel(
        imagePath: base + 'book_image_5.png',
        isDigit: true,
        title: '人机共生',
        subTitle: 'Sean Ye',
      ),
      _BookModel(
        imagePath: base + 'book_image_6.png',
        isDigit: true,
        title: '刻意练习',
        subTitle: '王峰',
      ),
      _BookModel(
        imagePath: base + 'book_image_7.png',
        isDigit: true,
        title: '奈飞文化手册',
        subTitle: '车路',
      ),
      _BookModel(
        imagePath: base + 'book_image_8.png',
        isDigit: true,
        title: '被忽视的孩子',
        subTitle: '覃羽辉',
      ),
    ];
  }

  static List<_BookModel> oneHourTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_9.png',
        isDigit: true,
        title: '法兰西往事：天才巴斯德的一生',
        subTitle: '葉一',
      ),
      _BookModel(
        imagePath: base + 'book_image_10.png',
        isDigit: true,
        title: '女孩快跑！',
        subTitle: '真实故事计划',
      ),
      _BookModel(
        imagePath: base + 'book_image_11.png',
        isDigit: true,
        title: '加勒比往事1：大西洋的尽头',
        subTitle: '十一点半',
      ),
      _BookModel(
        imagePath: base + 'book_image_12.png',
        isDigit: true,
        title: '简单有效的男士护理技巧',
        subTitle: '皮肤科老徐医生 等',
      ),
      _BookModel(
        imagePath: base + 'book_image_13.png',
        isDigit: true,
        title: '机器新脑：人工智能将如何进化？',
        subTitle: '神们自己',
      ),
    ];
  }

  static List<_BookModel> suspenseStoryTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_14.png',
        isDigit: true,
        title: '罪案调查科，罪终迷局',
        subTitle: '九滴水',
      ),
      _BookModel(
        imagePath: base + 'book_image_15.png',
        isDigit: true,
        title: '罪全书 1',
        subTitle: '蜘蛛',
      ),
      _BookModel(
        imagePath: base + 'book_image_16.png',
        isDigit: true,
        title: '虚无的十字架',
        subTitle: '东野圭吾',
      ),
      _BookModel(
        imagePath: base + 'book_image_17.png',
        isDigit: true,
        title: '罗生门',
        subTitle: '芥川龙之介',
      ),
      _BookModel(
        imagePath: base + 'book_image_18.png',
        isDigit: true,
        title: '拉普拉斯的魔女',
        subTitle: '东野圭吾',
      ),
    ];
  }

  static List<_BookModel> historyBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_19.png',
        isDigit: true,
        title: '以色列：一个民族的重生（好望角书系）',
        subTitle: '丹尼尔·戈迪斯',
      ),
      _BookModel(
        imagePath: base + 'book_image_20.png',
        isDigit: true,
        title: '中国通史（慢读系列，国史经典插图版）',
        subTitle: '蜘蛛',
      ),
      _BookModel(
        imagePath: base + 'book_image_21.png',
        isDigit: true,
        title: '你一定爱读的极简欧洲史',
        subTitle: '约翰·赫斯特',
      ),
      _BookModel(
        imagePath: base + 'book_image_22.png',
        isDigit: true,
        title: '谁亡了大宋？一小时理清「靖康之变」',
        subTitle: '丧心病狂刘老湿',
      ),
      _BookModel(
        imagePath: base + 'book_image_23.png',
        isDigit: true,
        title: '唐朝穿越指南：长安及各地人民生活手册',
        subTitle: '森林鹿',
      ),
    ];
  }

  static List<_BookModel> movieBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_24.png',
        isDigit: true,
        title: '82年生的金智英',
        subTitle: '【韩】赵南柱',
      ),
      _BookModel(
        imagePath: base + 'book_image_25.png',
        isDigit: true,
        title: '坡道上的家',
        subTitle: '角田光代',
      ),
      _BookModel(
        imagePath: base + 'book_image_26.png',
        isDigit: true,
        title: '萌医甜妻（原著名《陛下请自重》）',
        subTitle: '酒小七',
      ),
      _BookModel(
        imagePath: base + 'book_image_27.png',
        isDigit: true,
        title: '绝代双骄（胡一天、陈哲远主演）',
        subTitle: '古龙',
      ),
      _BookModel(
        imagePath: base + 'book_image_28.png',
        isDigit: true,
        title: '最美的时光',
        subTitle: '桐华',
      ),
    ];
  }

  static List<_BookModel> expressionBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_29.png',
        isDigit: true,
        title: '许三观卖血记',
        subTitle: '余华',
      ),
      _BookModel(
        imagePath: base + 'book_image_30.png',
        isDigit: true,
        title: '沉默的大多数',
        subTitle: '王小波',
      ),
      _BookModel(
        imagePath: base + 'book_image_31.png',
        isDigit: true,
        title: '挪威的森林',
        subTitle: '村上春树',
      ),
      _BookModel(
        imagePath: base + 'book_image_32.png',
        isDigit: true,
        title: '奥古斯都',
        subTitle: '【美】约翰·威廉斯',
      ),
      _BookModel(
        imagePath: base + 'book_image_33.png',
        isDigit: true,
        title: '无声告白',
        subTitle: '伍绮诗',
      ),
    ];
  }

  static List<_BookModel> economicBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_34.png',
        isDigit: true,
        title: '斯坦福极简经济学',
        subTitle: '蒂莫西·泰勒',
      ),
      _BookModel(
        imagePath: base + 'book_image_35.png',
        isDigit: true,
        title: '财务自由之路：7年内赚到你的第一个1000万',
        subTitle: '【德】博多·舍费尔',
      ),
      _BookModel(
        imagePath: base + 'book_image_36.png',
        isDigit: true,
        title: '创业思维：如何快速打造席卷市场的创业公司',
        subTitle: '马田隆明',
      ),
      _BookModel(
        imagePath: base + 'book_image_37.png',
        isDigit: true,
        title: '房地产投资岗入门指南',
        subTitle: '牧诗',
      ),
      _BookModel(
        imagePath: base + 'book_image_38.png',
        isDigit: true,
        title: '博弈论',
        subTitle: '霍文明',
      ),
    ];
  }

  static List<_BookModel> netBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_39.png',
        isDigit: true,
        title: '从 Python 开始学编程',
        subTitle: 'Vamei',
      ),
      _BookModel(
        imagePath: base + 'book_image_40.png',
        isDigit: true,
        title: '不止代码：程序员的进阶之路',
        subTitle: '程墨Morgan',
      ),
      _BookModel(
        imagePath: base + 'book_image_41.png',
        isDigit: true,
        title: '啊哈C语言！逻辑的挑战（修订版）',
        subTitle: '啊哈磊',
      ),
      _BookModel(
        imagePath: base + 'book_image_42.png',
        isDigit: true,
        title: '运营之光：我的互联网运营方法论与自白2.0（珍藏版）',
        subTitle: '黄有琛',
      ),
      _BookModel(
        imagePath: base + 'book_image_43.png',
        isDigit: true,
        title: '产品之光——从0到1教你做产品经理',
        subTitle: '张晋壹',
      ),
    ];
  }

  static List<_BookModel> loveBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_44.png',
        isDigit: true,
        title: '愈聊愈亲密',
        subTitle: '覃宇辉 等',
      ),
      _BookModel(
        imagePath: base + 'book_image_45.png',
        isDigit: true,
        title: '好的爱情',
        subTitle: '陈果',
      ),
      _BookModel(
        imagePath: base + 'book_image_46.png',
        isDigit: true,
        title: '如何优雅地挽回前任',
        subTitle: '林子',
      ),
      _BookModel(
        imagePath: base + 'book_image_47.png',
        isDigit: true,
        title: '好好分手：学会走出失恋阴霾',
        subTitle: '安慰记店长',
      ),
      _BookModel(
        imagePath: base + 'book_image_48.png',
        isDigit: true,
        title: '看不见的恋人',
        subTitle: '时光多吉 等',
      ),
    ];
  }

  static List<_BookModel> cureBookTest() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookModel(
        imagePath: base + 'book_image_49.png',
        isDigit: true,
        title: '感谢自己的不完美（升级版）',
        subTitle: '武志红',
      ),
      _BookModel(
        imagePath: base + 'book_image_50.png',
        isDigit: true,
        title: '我的生活不可能那么坏',
        subTitle: '【日】河尻圭吾（keigo）著',
      ),
      _BookModel(
        imagePath: base + 'book_image_51.png',
        isDigit: true,
        title: '幸福课：不完美人生的解答书',
        subTitle: '动机在杭州',
      ),
      _BookModel(
        imagePath: base + 'book_image_52.png',
        isDigit: true,
        title: '人性的弱点（新版）',
        subTitle: '戴尔·卡耐基',
      ),
      _BookModel(
        imagePath: base + 'book_image_53.png',
        isDigit: true,
        title: '女神从来不慌张（周迅、刘诗诗、孙俪、王菲...)',
        subTitle: '辫子歪歪',
      ),
    ];
  }
}

class _BookGoodModel {
  String imagePaht;
  String title;
  String author;
  String subTitle;
  double price;
  bool isFree;

  _BookGoodModel({
    this.imagePaht,
    this.title,
    this.author,
    this.subTitle,
    this.price,
    this.isFree,
  });

  _BookGoodModel.fromJson(Map json) {
    imagePaht = json['imagePath'];
    title = json['title'];
    author = json['author'];
    subTitle = json['subTitle'];
    price = json['price'];
    isFree = json['isFree'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['imagePath'] = imagePaht;
    json['title'] = title;
    json['author'] = author;
    json['subTitle'] = subTitle;
    json['price'] = price;
    json['isFree'] = isFree;
    return json;
  }

  static List<_BookGoodModel> test() {
    String base = 'assets/images/member/member_reading/';
    return [
      _BookGoodModel(
        imagePaht: base + 'book_good_image_0.png',
        title: '笑场',
        author: '李诞',
        subTitle: '高手从来不拔刀，真僧只说家常事',
        price: 17.99,
        isFree: true,
      ),
      _BookGoodModel(
        imagePaht: base + 'book_good_image_1.png',
        title: 'Linux命令行与shell脚本编程大全',
        author: 'Richard Blum',
        subTitle: '一本关于Linus命令行与shell脚本编程的书',
        price: 54.99,
        isFree: false,
      ),
      _BookGoodModel(
        imagePaht: base + 'book_good_image_2.png',
        title: '白话区块链',
        author: '蒋勇',
        subTitle: '涵盖区块链底层技术，典型业务场景',
        price: 25,
        isFree: true,
      ),
      _BookGoodModel(
        imagePaht: base + 'book_good_image_3.png',
        title: '聪明人用方格笔记本',
        author: '高桥政史',
        subTitle: '开始新的笔记之路，开启新的人生旅途',
        price: 17.99,
        isFree: true,
      ),
      _BookGoodModel(
        imagePaht: base + 'book_good_image_4.png',
        title: 'Nginx完全开发指南：使用C、C++和OpenResty',
        author: '罗剑锋',
        subTitle: '一个近乎「全能」的服务器软件开发书',
        price: 58.8,
        isFree: true,
      ),
      _BookGoodModel(
        imagePaht: base + 'book_good_image_5.png',
        title: '浴缸里的惊叹：256道让你恍然大悟的趣题',
        author: '顾森',
        subTitle: '一个疯狂数学爱好者的数学笔记。',
        price: 18,
        isFree: true,
      ),
    ];
  }
}
