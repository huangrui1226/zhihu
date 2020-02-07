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
        children.add(Container(
          padding: EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 44,
          child: Text(
            '暂未开播',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
        children.add(_NoSeedingCellView(modelList: this.noSeedingList));
      }

      /// 正在直播
      if (this.isSeedingList.length != 0) {
        children.add(Container(
          padding: EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 44,
          child: Text(
            '正在直播',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
        children.add(Expanded(child: _SeedingCellView(modelList: this.isSeedingList)));
      }
      return Container(
        child: SmartRefresher(
          onRefresh: () {
            controller.refreshCompleted();
          },
          controller: controller,
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: children,
            ),
          ),
        ),
      );
    }
  }
}

class _SeedingCellView extends StatelessWidget {
  final List<DirectSeedModel> modelList;

  _SeedingCellView({
    Key key,
    this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: List.generate(15, (index) {
        return Container(
          width: 100,
          color: Colors.red,
        );
      }),
    );
  }
}

class _NoSeedingCellView extends StatelessWidget {
  final List<DirectSeedModel> modelList;
  _NoSeedingCellView({
    Key key,
    this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(this.modelList.length, (index) {
        return _cellView(this.modelList[index]);
      }),
    );
  }

  Widget _cellView(DirectSeedModel model) {
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
