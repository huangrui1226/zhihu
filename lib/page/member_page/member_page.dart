import 'package:flutter/material.dart';
import 'package:zhihu/page/member_page/member_reading_view.dart';
import 'package:zhihu/page/member_page/member_recommand_view.dart';

class MemberPage extends StatefulWidget {
  static String rName = 'MemberPage';

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> with TickerProviderStateMixin {
  TabController tabController;
  List<Tab> tabList;
  List<Widget> tabViewList;

  @override
  void initState() {
    tabList = [
      Tab(child: Text('会员推荐')),
      Tab(child: Text('读书会')),
      Tab(child: Text('杂志')),
      Tab(child: Text('盐选专栏')),
      Tab(child: Text('Live讲座')),
    ];
    tabViewList = [
      MemberRecommandView(),
      MemberReadingView(),
      MemberRecommandView(),
      MemberRecommandView(),
      MemberRecommandView(),
    ];
    tabController = TabController(
      vsync: this,
      length: tabList.length,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _AppBar(),
          _MyTabbar(tabController, tabList: tabList),
          Divider(height: 1, color: Color.fromRGBO(210, 211, 212, 1.0)),
          Expanded(child: _MyTabbarView(tabViewList, tabController)),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: top, left: 15),
      height: 59 + top,
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/member/my_user_icon.png'),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Text(
                              '黄瑞',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            width: 96,
                            height: 18,
                            child: Image.asset('assets/images/member/member_indicator.png'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        '加入盐选会员享各种精彩课程',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyTabbar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabList;

  _MyTabbar(
    this.controller, {
    this.tabList = const [],
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(203, 153, 79, 1.0);

    return Container(
      height: 43,
      child: TabBar(
        isScrollable: true,
        controller: controller,
        tabs: tabList,
        indicatorColor: color,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: color,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: Colors.black45,
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _MyTabbarView extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabViewList;

  _MyTabbarView(
    this.tabViewList,
    this.controller, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: tabViewList,
    );
  }
}
