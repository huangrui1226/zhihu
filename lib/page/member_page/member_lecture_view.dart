import 'package:flutter/material.dart';

double _margin = 20.0;

class MemberLectureView extends StatefulWidget {
  @override
  _MemberLectureViewState createState() => _MemberLectureViewState();
}

class _MemberLectureViewState extends State<MemberLectureView> {
  List<_BookGoodModel> bookList;
  List<_CategoryModel> categoryList;
  _CategoryModel selectCategory;

  @override
  void initState() {
    bookList = _BookGoodModel.test();
    categoryList = _CategoryModel.test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _ShiftView(),
          _CategoryView(
            categoryList: categoryList,
            selectCategory: selectCategory,
            selectBlock: (model) => onCategoryClicked(model),
          ),
          _BookView(bookList: bookList),
        ],
      ),
    );
  }

  onCategoryClicked(_CategoryModel model) {
    selectCategory = model;
    setState(() {});
  }
}

class _ShiftView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1),
      height: 40,
      color: Color.fromARGB(255, 244, 245, 246),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final List<_CategoryModel> categoryList;
  final _CategoryModel selectCategory;
  final _CategoryModel Function(_CategoryModel model) selectBlock;

  _CategoryView({
    Key key,
    this.categoryList,
    this.selectCategory,
    this.selectBlock,
  }) : super(key: key);

  @override
  __CategoryViewState createState() => __CategoryViewState();
}

class __CategoryViewState extends State<_CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        children: widget.categoryList.map((model) => _cellView(model, widget.selectBlock)).toList(),
      ),
    );
  }

  Widget _cellView(_CategoryModel model, block) {
    Color selectColor = Color.fromRGBO(203, 153, 79, 1.0);

    return GestureDetector(
      onTap: () {
        block(model);
      },
      child: Container(
        height: 30,
        width: 68,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 246, 247),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(model.title, style: TextStyle(color: widget.selectCategory == model ? selectColor : Colors.black)),
      ),
    );
  }
}

class _BookView extends StatelessWidget {
  final List<_BookGoodModel> bookList;

  _BookView({
    Key key,
    this.bookList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.5),
      child: Column(
        children: bookList.map((model) => _cellView(model)).toList(),
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

class _CategoryModel {
  String title;

  _CategoryModel({
    this.title,
  });

  _CategoryModel.fromJson(Map json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    return json;
  }

  static List<_CategoryModel> test() {
    return [
      _CategoryModel(title: '全部分类'),
      _CategoryModel(title: '科学'),
      _CategoryModel(title: '前沿'),
      _CategoryModel(title: '财商'),
      _CategoryModel(title: '文学'),
      _CategoryModel(title: '艺术'),
      _CategoryModel(title: '社科'),
      _CategoryModel(title: '成长'),
      _CategoryModel(title: '职人'),
      _CategoryModel(title: '通关'),
      _CategoryModel(title: '乐活'),
      _CategoryModel(title: '亲密'),
      _CategoryModel(title: '亲子'),
    ];
  }
}
