import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zhihu/widget/my_tabbar.dart';

class DirectSeedPage extends StatefulWidget {
  static String rName = 'DirectSeedPage';

  @override
  _DirectSeedPageState createState() => _DirectSeedPageState();
}

class _DirectSeedPageState extends State<DirectSeedPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabTitleList;
  List<_SeedModel> _seedModelList;

  @override
  void initState() {
    _tabTitleList = ['直播', '关注'];
    _tabController = TabController(
      length: _tabTitleList.length,
      vsync: this,
    );
    _seedModelList = _SeedModel.test();
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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: top + 10),
        child: Column(
          children: <Widget>[
            Container(
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
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                    _DirectView(list: _seedModelList),
                    Container(),
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

class _DirectView extends StatelessWidget {
  final List<_SeedModel> list;

  _DirectView({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: GridView(
        gridDelegate: MySliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 369 / 319.0,
        ),
        children: List.generate(list.length + 1, (index) {
          if (index == 0) {
            return Container(
              child: Image.asset('assets/images/main_seed/main_seed_banner.png'),
            );
          } else {
            _SeedModel model = list[index - 1];
            return _CellView(model: model);
          }
        }),
      ),
    );
  }
}

class _CellView extends StatelessWidget {
  final _SeedModel model;

  _CellView({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(model.seedImageUrl, fit: BoxFit.fitWidth),
                  ),
                ),
                model.isSeeding == true
                    ? Container()
                    : Positioned(
                        left: 0,
                        top: 0,
                        width: 38,
                        height: 18,
                        child: Container(
                          child: Center(
                            child: Text(
                              '预告',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF383ABD), Color(0xFF65A9FD)],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 31,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: model.isSeeding ? Color(0xFFFF3266) : Colors.transparent),
                              ),
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  model.userIconUrl,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                model.username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Text(
                            model.audience == 0 ? '' : model.audience.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            aspectRatio: 369 / 208.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text(
              model.title,
              maxLines: model.subTitle == '' ? 2 : 1,
            ),
          ),
          model.subTitle != ''
              ? Container(
                  child: Text(
                    model.subTitle,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class MySliverGridDelegateWithFixedCrossAxisCount extends SliverGridDelegate {
  /// Creates a delegate that makes grid layouts with a fixed number of tiles in
  /// the cross axis.
  ///
  /// All of the arguments must not be null. The `mainAxisSpacing` and
  /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
  /// and `childAspectRatio` arguments must be greater than zero.
  const MySliverGridDelegateWithFixedCrossAxisCount({
    @required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
  })  : assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
        assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
        assert(childAspectRatio != null && childAspectRatio > 0);

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of logical pixels between each child along the main axis.
  final double mainAxisSpacing;

  /// The number of logical pixels between each child along the cross axis.
  final double crossAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent of each child.
  final double childAspectRatio;

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(childAspectRatio > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent = constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = childCrossAxisExtent / childAspectRatio;
    return MySliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(MySliverGridDelegateWithFixedCrossAxisCount oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.childAspectRatio != childAspectRatio;
  }
}

class MySliverGridRegularTileLayout extends SliverGridLayout {
  /// Creates a layout that uses equally sized and spaced tiles.
  ///
  /// All of the arguments must not be null and must not be negative. The
  /// `crossAxisCount` argument must be greater than zero.
  const MySliverGridRegularTileLayout({
    @required this.crossAxisCount,
    @required this.mainAxisStride,
    @required this.crossAxisStride,
    @required this.childMainAxisExtent,
    @required this.childCrossAxisExtent,
    @required this.reverseCrossAxis,
  })  : assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisStride != null && mainAxisStride >= 0),
        assert(crossAxisStride != null && crossAxisStride >= 0),
        assert(childMainAxisExtent != null && childMainAxisExtent >= 0),
        assert(childCrossAxisExtent != null && childCrossAxisExtent >= 0),
        assert(reverseCrossAxis != null);

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the next tile in the main axis.
  final double mainAxisStride;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the next tile in the cross axis.
  final double crossAxisStride;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the same tile in the main axis.
  final double childMainAxisExtent;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the same tile in the cross axis.
  final double childCrossAxisExtent;

  /// Whether the children should be placed in the opposite order of increasing
  /// coordinates in the cross axis.
  ///
  /// For example, if the cross axis is horizontal, the children are placed from
  /// left to right when [reverseCrossAxis] is false and from right to left when
  /// [reverseCrossAxis] is true.
  ///
  /// Typically set to the return value of [axisDirectionIsReversed] applied to
  /// the [SliverConstraints.crossAxisDirection].
  final bool reverseCrossAxis;

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    int count = mainAxisStride > 0.0 ? crossAxisCount * (scrollOffset ~/ mainAxisStride) : 0;
    return count;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    if (mainAxisStride > 0.0) {
      final int mainAxisCount = (scrollOffset / mainAxisStride).ceil();
      int count = math.max(0, crossAxisCount * mainAxisCount - 1);
      return count;
    }
    return 0;
  }

  double _getOffsetFromStartInCrossAxis(double crossAxisStart) {
    if (reverseCrossAxis) return crossAxisCount * crossAxisStride - crossAxisStart - childCrossAxisExtent - (crossAxisStride - childCrossAxisExtent);
    return crossAxisStart;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    if (index == 0) {
      return SliverGridGeometry(
        scrollOffset: 0,
        crossAxisOffset: 0,
        crossAxisExtent: crossAxisStride * crossAxisCount - (crossAxisStride - childCrossAxisExtent),
        mainAxisExtent: childMainAxisExtent,
      );
    } else {
      final double crossAxisStart = ((index + 1) % crossAxisCount) * crossAxisStride;
      return SliverGridGeometry(
        scrollOffset: ((index + 1) ~/ crossAxisCount) * mainAxisStride,
        crossAxisOffset: _getOffsetFromStartInCrossAxis(crossAxisStart),
        mainAxisExtent: childMainAxisExtent,
        crossAxisExtent: childCrossAxisExtent,
      );
    }
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    assert(childCount != null);
    print('childCount: $childCount');
    final int mainAxisCount = ((childCount - 1) ~/ crossAxisCount) + 1;
    final double mainAxisSpacing = mainAxisStride - childMainAxisExtent;
    return mainAxisStride * mainAxisCount - mainAxisSpacing;
  }
}

class _SeedModel {
  String seedImageUrl;
  String username;
  String userIconUrl;
  String title;
  String subTitle;
  bool isSeeding;
  int audience;

  _SeedModel({
    this.seedImageUrl,
    this.username,
    this.userIconUrl,
    this.title,
    this.subTitle,
    this.isSeeding,
    this.audience,
  });

  _SeedModel.fromJson(Map json) {
    seedImageUrl = json['seedImageUrl'];
    username = json['username'];
    userIconUrl = json['userIconUrl'];
    title = json['title'];
    subTitle = json['subTitle'];
    isSeeding = json['isSeeding'];
    audience = json['audience'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['seedImageUrl'] = seedImageUrl;
    json['username'] = username;
    json['userIconUrl'] = userIconUrl;
    json['title'] = title;
    json['subTitle'] = subTitle;
    json['isSeeding'] = isSeeding;
    json['audience'] = audience;
    return json;
  }

  static List<_SeedModel> test() {
    return [
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_0.png',
        username: 'Eternal Evan',
        userIconUrl: 'assets/images/main_seed/seed_user_0.png',
        title: '聊一聊你们想知道的播音问题吧',
        subTitle: '',
        isSeeding: true,
        audience: 2017,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_1.png',
        username: 'WJ ZHAO',
        userIconUrl: 'assets/images/main_seed/seed_user_1.png',
        title: '你们喜欢听什么歌呀？',
        subTitle: '',
        isSeeding: true,
        audience: 546,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_2.png',
        username: '秋官',
        userIconUrl: 'assets/images/main_seed/seed_user_2.png',
        title: '尾巴尾巴（手绘）',
        subTitle: '',
        isSeeding: true,
        audience: 101,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_3.png',
        username: '哈哈欠为你违逆',
        userIconUrl: 'assets/images/main_seed/seed_user_3.png',
        title: '爱传万家 说出你的故事',
        subTitle: '',
        isSeeding: true,
        audience: 71,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_4.png',
        username: '字嘲',
        userIconUrl: 'assets/images/main_seed/seed_user_4.png',
        title: '教资考复习练琴间隔唠嗑',
        subTitle: '',
        isSeeding: true,
        audience: 42,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_5.png',
        username: '唔好再益我啦',
        userIconUrl: 'assets/images/main_seed/seed_user_5.png',
        title: '聊聊疫情期间大家关心的问题',
        subTitle: '02-06 16:00，今天开播',
        isSeeding: false,
        audience: 0,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_6.png',
        username: '半年一次的邂逅',
        userIconUrl: 'assets/images/main_seed/seed_user_6.png',
        title: '韩老师陪你宅着学《孟子》',
        subTitle: '02-06 20:00，今天开播',
        isSeeding: false,
        audience: 0,
      ),
      _SeedModel(
        seedImageUrl: 'assets/images/main_seed/seed_icon_7.png',
        username: '李自行',
        userIconUrl: 'assets/images/main_seed/seed_user_7.png',
        title: '长大以后麻烦就会变少吗',
        subTitle: '02-06 20:30，今天开播',
        isSeeding: false,
        audience: 0,
      ),
    ];
  }
}
