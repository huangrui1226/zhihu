import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zhihu/page/main_page/direct_seed/direct_seed_focus_view.dart';
import 'package:zhihu/page/main_page/direct_seed/direct_seed_view.dart';
import 'package:zhihu/widget/my_tabbar.dart';

class DirectSeedPage extends StatefulWidget {
  static String rName = 'DirectSeedPage';

  @override
  _DirectSeedPageState createState() => _DirectSeedPageState();
}

class _DirectSeedPageState extends State<DirectSeedPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabTitleList;
  List<DirectSeedModel> _seedModelList; // 直播间数据
  List<DirectSeedModel> _focusSeedModelList; // 关注的主播

  @override
  void initState() {
    _seedModelList = DirectSeedModel.test();
    _focusSeedModelList = _seedModelList.where((model) {
      return true;
    }).toList();
    _tabTitleList = ['直播', '关注(${_focusSeedModelList.length})'];
    _tabController = TabController(
      length: _tabTitleList.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Color(0xFFEAEBEC),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: top + 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 168,
                    child: MyTabBar(
                      labelPadding: EdgeInsets.only(bottom: 6),
                      indicatorColor: Colors.black,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                      indicatorWeight: 3,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      controller: _tabController,
                      tabs: List.generate(_tabTitleList.length, (index) {
                        String title = _tabTitleList[index];
                        return MyTab(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(child: Text(title)),
                          ),
                        );
                      }),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      child: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    DirectSeedView(list: _seedModelList),
                    DirectSeedFocusView(modelList: _focusSeedModelList, tabController: _tabController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}