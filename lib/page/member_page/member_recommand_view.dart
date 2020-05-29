import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double _margin = 20.0;

class MemberRecommandView extends StatefulWidget {
  @override
  _MemberRecommandViewState createState() => _MemberRecommandViewState();
}

class _MemberRecommandViewState extends State<MemberRecommandView> {
  List<_CategoryModel> modelList;
  List<_BookModel> myBookshelfList; // 我的书架
  List<_LecturesModel> recommandList; // 热门推荐
  List<_DiscountModel> discountList; // 今日限免 & 折扣
  List<_BookModel> freeBooksList;
  List<_LecturesModel> suspenseList; // 悬疑推荐
  List<_PopListModel> popList; // 热榜
  List<_LecturesModel> popLectureList; // 盐选热榜

  @override
  void initState() {
    modelList = _CategoryModel.test();
    myBookshelfList = _BookModel.test();
    recommandList = _LecturesModel.test();
    discountList = _DiscountModel.test();
    freeBooksList = _BookModel.freeListTest();
    suspenseList = _LecturesModel.suspenseListTest();
    popList = _PopListModel.popListTest();
    popLectureList = _LecturesModel.popListTest();
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
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
          _FreeBooksTrialView(freeBookList: freeBooksList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
          _SuspenseView(suspenseList: suspenseList),
          Container(height: 8, color: Color.fromRGBO(245, 246, 247, 1.0)),
          _PopListView(modelList: popList, lectureList: popLectureList),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_margin),
      child: Row(
          children: List.generate(modelList.length, (index) {
        _CategoryModel model = modelList[index];
        return _cellView(model, context);
      })),
    );
  }

  Widget _cellView(_CategoryModel model, BuildContext context) {
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
    double ratio = 182 / 100.0;
    double width = (MediaQuery.of(context).size.width - _margin * 2 - 10) / 2;
    double height = width / ratio + 80;
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
      padding: EdgeInsets.only(top: 16, bottom: 4),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: _margin, right: _margin),
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
            height: height + 16,
            child: GridView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: _margin),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            offset: Offset(0, 0),
            blurRadius: 8,
          ),
        ],
      ),
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
                  flex: 152,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 7.5, left: 13, right: 13),
                          child: Center(
                            child: Text(
                              model.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              '原价：¥${model.originalPrice}',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 60,
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 251, 152, 12), width: 0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      model.currentPrice == 0 ? '免费领取' : '${model.currentPrice} 元领取',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 251, 152, 12),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 32, child: Container()),
              ],
            ),
          ),
          () {
            if (model.currentPrice == model.originalPrice) {
              return Container();
            } else if (model.currentPrice == 0) {
              // 限免
              return Positioned(
                width: 41,
                height: 18,
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 132, 254, 1.0),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      '限免',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // 折扣
              return Positioned(
                width: 41,
                height: 18,
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(251, 152, 12, 1.0),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      '折扣',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              );
            }
          }(),
        ],
      ),
    );
  }
}

class _FreeBooksTrialView extends StatelessWidget {
  final List<_BookModel> freeBookList;

  _FreeBooksTrialView({
    Key key,
    this.freeBookList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = 236 / 482;
    double width = MediaQuery.of(context).size.width - _margin * 2;
    double cellWidth = (width - 10 * 2) / 3;
    double cellHeight = cellWidth / ratio;
    double height = cellHeight * 2;

    return Container(
      padding: EdgeInsets.only(left: _margin, right: _margin, bottom: 16),
      child: Column(
        children: <Widget>[
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('小说免费试读', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            height: height,
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: ratio,
              ),
              children: freeBookList.map((model) {
                return _cellView(model);
              }).toList(),
            ),
          ),
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('为你讲书', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('进入栏目', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          AspectRatio(
            child: Image.asset('assets/images/member/member_recommand/book_read_banner.png'),
            aspectRatio: 748 / 310,
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
          AspectRatio(
            child: Image.asset(model.imagePath),
            aspectRatio: 236 / 314,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              model.title,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: Text(
              model.subTitle,
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuspenseView extends StatelessWidget {
  final List<_LecturesModel> suspenseList;

  _SuspenseView({
    Key key,
    this.suspenseList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = 364 / 368.0;
    double width = MediaQuery.of(context).size.width - _margin * 2;
    double cellWidth = (width - 10) / 2;
    double cellHeight = cellWidth / ratio;
    double height = cellHeight * 2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _margin),
      child: Column(
        children: <Widget>[
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('悬疑一时爽，爽完心慌慌？', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            height: height,
            child: GridView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: ratio,
              ),
              children: suspenseList.map((model) {
                return _cellView(model);
              }).toList(),
            ),
          ),
          Container(
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('精选专题', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          () {
            double ratio = 748 / 311.0;
            double height = MediaQuery.of(context).size.width - _margin * 2;
            double width = height / ratio;

            String base = 'assets/images/member/member_recommand/';
            List<String> imageList = List.generate(5, (index) {
              return base + 'suspense_select_$index.png';
            });

            return Container(
              margin: EdgeInsets.only(bottom: 16),
              height: width,
              child: GridView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / ratio,
                ),
                children: imageList.map((path) {
                  return Image.asset(path);
                }).toList(),
              ),
            );
          }(),
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

class _PopListView extends StatelessWidget {
  final List<_PopListModel> modelList;
  final List<_LecturesModel> lectureList;

  _PopListView({
    Key key,
    this.modelList,
    this.lectureList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = 748 / 200.0;
    double width = MediaQuery.of(context).size.width - _margin * 2;
    double height = width / ratio;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: _margin),
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('盐选榜单', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          Container(
            height: height + 16,
            child: GridView(
              padding: EdgeInsets.only(left: _margin, right: _margin, bottom: 16),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0 / ratio,
              ),
              children: modelList.map((model) {
                return _popListView(model);
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: _margin),
            height: 61,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text('历史长河曾埋藏着哪些故事？', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                Text('查看更多', style: TextStyle(color: Colors.black38, fontSize: 13)),
                Icon(Icons.arrow_right, size: 14),
              ],
            ),
          ),
          () {
            double ratio = 364 / 368.0;
            double width = MediaQuery.of(context).size.width - _margin * 2;
            double cellWidth = (width - 10) / 2;
            double cellHeight = cellWidth / ratio;
            double height = cellHeight * 2;

            return Container(
              height: height,
              child: GridView(
                padding: EdgeInsets.symmetric(horizontal: _margin),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: ratio,
                ),
                children: lectureList.map((model) {
                  return _cellView(model);
                }).toList(),
              ),
            );
          }(),
        ],
      ),
    );
  }

  Widget _popListView(_PopListModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 100 / 200.0,
            child: Image.asset(model.imagePath),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(model.titleList.length, (index) {
                  String title = model.titleList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 14,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: () {
                                switch (index) {
                                  case 0:
                                    return Colors.red;
                                  case 1:
                                    return Colors.orange;
                                  case 2:
                                    return Colors.amber;
                                  default:
                                    return Colors.black;
                                }
                              }(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
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

  static List<_BookModel> freeListTest() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _BookModel(
        imagePath: base + 'book_image_1.png',
        isDigit: true,
        title: '庆余年',
        subTitle: '猫腻',
      ),
      _BookModel(
        imagePath: base + 'book_image_2.png',
        isDigit: true,
        title: '鬼吹灯（盗墓者的经历）',
        subTitle: '本物天下霸唱',
      ),
      _BookModel(
        imagePath: base + 'book_image_3.png',
        isDigit: true,
        title: '盗墓笔记',
        subTitle: '南派三叔',
      ),
      _BookModel(
        imagePath: base + 'book_image_4.png',
        isDigit: true,
        title: '斗罗大陆II绝世唐门',
        subTitle: '唐家三少',
      ),
      _BookModel(
        imagePath: base + 'book_image_5.png',
        isDigit: true,
        title: '全职高手',
        subTitle: '蝴蝶蓝',
      ),
      _BookModel(
        imagePath: base + 'book_image_6.png',
        isDigit: true,
        title: '大道朝天',
        subTitle: '猫腻',
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

  static List<_LecturesModel> suspenseListTest() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _LecturesModel(
        imagePath: base + 'suspense_lecture_0.png',
        title: '完美谋杀：一位老刑警笔下的7个真实重案故事',
        numberOfArticle: 22,
      ),
      _LecturesModel(
        imagePath: base + 'suspense_lecture_1.png',
        title: '消失的凶手：高智商谋杀背后的人性深渊',
        numberOfArticle: 11,
      ),
      _LecturesModel(
        imagePath: base + 'suspense_lecture_2.png',
        title: '治愈你，杀了你：一个心理医生的完美犯罪记录',
        numberOfArticle: 18,
      ),
      _LecturesModel(
        imagePath: base + 'suspense_lecture_3.png',
        title: '深夜惊奇：你不敢打开的睡前故事',
        numberOfArticle: 32,
      ),
    ];
  }

  static List<_LecturesModel> popListTest() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _LecturesModel(
        imagePath: base + 'lecture_image_8.png',
        title: '帝王传奇之三国：明君，奸雄与庸主',
        numberOfArticle: 12,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_9.png',
        title: '从民女到皇后：被「宠爱」的阴丽华的一生',
        numberOfArticle: 9,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_10.png',
        title: '宫斗、争宠、上位：大清皇帝的女人们',
        numberOfArticle: 23,
      ),
      _LecturesModel(
        imagePath: base + 'lecture_image_11.png',
        title: '历史中的潜伏时刻：行走在人性边缘的间谍们',
        numberOfArticle: 3,
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

class _PopListModel {
  String imagePath;
  List<String> titleList;

  _PopListModel({
    this.imagePath,
    this.titleList,
  });

  _PopListModel.fromJson(Map json) {
    imagePath = json['titlePath'];
    titleList = json['titleList'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['imagePath'] = imagePath;
    json['titleList'] = titleList;
    return json;
  }

  static List<_PopListModel> popListTest() {
    String base = 'assets/images/member/member_recommand/';
    return [
      _PopListModel(
        imagePath: base + 'pop_list_image_0.png',
        titleList: [
          '新型冠状病毒感染的肺炎防护手册',
          '治愈你，杀了你：一个心理医生的完美犯罪记录',
          '非典纪实：瘟疫与人类的生存战',
        ],
      ),
      _PopListModel(
        imagePath: base + 'pop_list_image_1.png',
        titleList: [
          '唯有医生看透的人性：12个直击生死的病房实录',
          '人间本多情：20个聚焦人性底色的真实故事',
          '你不知道的工作：揭秘30种小众职业',
        ],
      ),
      _PopListModel(
        imagePath: base + 'pop_list_image_2.png',
        titleList: [
          '逃离金三角：亡命恶人',
          '我不了解人类2：大灾难下的终极抉择',
          '历史中的潜伏时刻：行走在人性边缘的间谍们',
        ],
      ),
    ];
  }
}
