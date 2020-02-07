import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zhihu/page/main_page/direct_seed/direct_seed_view.dart';

class DirectSeedFocusView extends StatefulWidget {
  final List<DirectSeedModel> modelList;
  final TabController tabController;

  DirectSeedFocusView({
    Key key,
    this.modelList,
    this.tabController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DirectSeedFocusViewState();
  }
}

class _DirectSeedFocusViewState extends State<DirectSeedFocusView> {
  RefreshController controller;
  List<DirectSeedModel> isSeedingList;
  List<DirectSeedModel> noSeedingList;

  @override
  void initState() {
    controller = RefreshController();
    isSeedingList = widget.modelList.where((model) {
      return model.isSeeding;
    }).toList();
    noSeedingList = widget.modelList.where((model) {
      return model.isSeeding == false;
    }).toList();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.modelList.length == 0) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              child: Image.asset('assets/images/main_seed/direct_seed_focus_nodata.png'),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                '你关注的主播暂未开播',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => widget.tabController.animateTo(0),
              child: Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.only(bottom: 160),
                child: Text(
                  '去直播首页看看',
                  style: TextStyle(
                    color: Color(0xFF0078FF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      int count;
      List<Widget> children = [];

      /// 暂未开播
      if (this.noSeedingList.length != 0) {
        children.add(_SeedingTitleView('暂未开播'));
        children.addAll(this.noSeedingList.map((model) => _NoSeedingCellView(model: model)));
      }

      /// 正在直播
      if (this.isSeedingList.length != 0) {
        children.add(_SeedingTitleView('正在直播'));
        for (int i = 0; i <= this.isSeedingList.length / 2; i++) {
          Widget row = Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _IsSeedingCellView(model: this.isSeedingList[i * 2]),
                (i + 1) * 2 > this.isSeedingList.length ? Container() : _IsSeedingCellView(model: this.isSeedingList[i * 2 + 1]),
              ],
            ),
          );
          children.add(row);
        }
      }

      return Container(
        child: SmartRefresher(
          onRefresh: () {
            controller.refreshCompleted();
          },
          controller: controller,
          child: ListView(
            children: children,
          ),
        ),
      );
    }
  }
}

class _SeedingTitleView extends StatelessWidget {
  final String title;

  _SeedingTitleView(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      height: 44,
      child: Text(
        this.title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _NoSeedingCellView extends StatelessWidget {
  final DirectSeedModel model;

  _NoSeedingCellView({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(model.userIconUrl),
            ),
            width: 34,
            height: 34,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      model.username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      model.subTitle == '' ? '测试' : model.subTitle,
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IsSeedingCellView extends StatelessWidget {
  final DirectSeedModel model;

  _IsSeedingCellView({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double width = (scrWidth - 15 * 3) / 2;

    /// width 372,height 372,ratio 1:1
    return Container(
      height: width,
      width: width,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 271,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    /// width 369, height 208, ratio 369 / 208.0
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AspectRatio(
                        aspectRatio: 369 / 208.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(model.seedImageUrl, fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 35,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17.5),
                                border: Border.all(color: Colors.orange, width: 1),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14.5),
                                child: Image.asset(model.userIconUrl),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(model.username),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25.5,
                      left: 3,
                      width: 29,
                      height: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 50, 102, 1.0),
                              Color.fromRGBO(255, 148, 98, 1.0),
                              Color.fromRGBO(255, 50, 102, 1.0),
                            ],
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                        ),
                        child: Center(
                            child: Text(
                          '直播中',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        )),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                        child: Text(
                          model.audience == 0 ? '' : model.audience.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 101,
              child: Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(model.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
