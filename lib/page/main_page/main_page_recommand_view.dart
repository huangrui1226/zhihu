import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainPageRecmndView extends StatefulWidget {
  @override
  _MainPageRecmndViewState createState() => _MainPageRecmndViewState();
}

class _MainPageRecmndViewState extends State<MainPageRecmndView> with TickerProviderStateMixin {
  List<_RecommandModel> modelList = _RecommandModel.test();
  AnimationController updateAnim; // 刷新成功后提示框动画
  RefreshController refreshController; // 刷新控制器

  @override
  void initState() {
    refreshController = RefreshController();
    _configUpdateViewAnimation();
    super.initState();
  }

  @override
  void dispose() {
    updateAnim.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F6F7),
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            controller: refreshController,
            onRefresh: () {
              updateAnim.forward();
              refreshController.refreshCompleted();
            },
            child: ListView(
              children: List.generate(modelList.length, (i) {
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 8),
                  child: _CellView(
                    model: modelList[i],
                  ),
                );
              }),
            ),
          ),
          _UpdateView(updateAnim.value * 30),
        ],
      ),
    );
  }

  _configUpdateViewAnimation() {
    updateAnim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    updateAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1)).then((val) {
          updateAnim.reverse();
        });
      }
    });
    updateAnim.addListener(() {
      setState(() {});
    });
  }
}

// 关注动态已更新视图
class _UpdateView extends StatelessWidget {
  final double height;
  _UpdateView(this.height);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: this.height,
          color: Colors.white,
          child: Center(
            child: Text(
              '推荐已更新',
              style: TextStyle(
                color: Color(0xFF0084FE),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Divider(height: 1, color: Color(0xFFE3E4E5)),
      ],
    );
  }
}

class _CellView extends StatelessWidget {
  final _RecommandModel model;

  _CellView({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.5, bottom: 12, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              model.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    _userView(),
                    Container(
                      child: Text(
                        model.subTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              () {
                if (model.detailImageUrl == '') {
                  return Container();
                } else {
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 95,
                    height: 66,
                    child: Image.asset(model.detailImageUrl),
                  );
                }
              }()
            ],
          ),
          _infoView(),
        ],
      ),
    );
  }

  Widget _userView() {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 头像
          Container(
            margin: EdgeInsets.only(right: 8),
            width: 20,
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(model.iconUrl),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              model.username,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                model.userSign,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoView() {
    return Container(
      margin: EdgeInsets.only(left: 2, top: 6),
      child: Text(
        '${model.greatCount} 赞同 - ${model.discussCount} 评论',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _RecommandModel {
  String iconUrl;
  String detailImageUrl;
  String username;
  String userSign;
  String title;
  String subTitle;
  int greatCount;
  int discussCount;

  _RecommandModel({
    this.iconUrl,
    this.detailImageUrl,
    this.username,
    this.userSign,
    this.title,
    this.subTitle,
    this.greatCount,
    this.discussCount,
  });

  _RecommandModel.fromJson(Map<String, dynamic> json) {
    iconUrl = json['iconUrl'];
    detailImageUrl = json['detailImageUrl'];
    username = json['username'];
    userSign = json['userSign'];
    title = json['title'];
    subTitle = json['subTitle'];
    greatCount = json['greatCount'];
    discussCount = json['discussCount'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['iconUrl'] = iconUrl;
    map['detailImageUrl'] = detailImageUrl;
    map['username'] = username;
    map['userSign'] = userSign;
    map['title'] = title;
    map['subTitle'] = subTitle;
    map['greatCount'] = greatCount;
    map['discussCount'] = discussCount;
    return map;
  }

  static List<_RecommandModel> test() {
    return [
      _RecommandModel(
        iconUrl: 'assets/images/main_recommand/xinyue.png',
        detailImageUrl: '',
        username: '新月',
        userSign: '',
        title: '有什么适合情侣约会的活动？',
        subTitle: '谢邀，以下我是复制粘贴的，觉得你们可以试试，一起去看一场演唱会。为你自己或是他的爱豆疯狂一次。顺便找一找青春的记忆。一起玩一次真心话大冒险。Ta让做什么就做什么。体验一把恋人朋友的快乐。',
        greatCount: 591,
        discussCount: 47,
      ),
      _RecommandModel(
        iconUrl: 'assets/images/main_recommand/gushidanganju.png',
        detailImageUrl: 'assets/images/main_recommand/detail_0.png',
        username: '故事档案局',
        userSign: '知乎官方账号',
        title: '美国最让人不解的地方是什么？',
        subTitle: '这是一起发生在美国的真实案件，30年间，和她同居过的男性中至少有5个非正常死亡，而她每次都能逃脱审判，直到这起颈环炸弹劫案发生，这位极有可能是连环杀手的女性才落入法网。这个案件有时被称作',
        greatCount: 2979,
        discussCount: 39,
      ),
      _RecommandModel(
        iconUrl: 'assets/images/main_recommand/lengmanman.png',
        detailImageUrl: 'assets/images/main_recommand/detail_1.png',
        username: '冷慢慢',
        userSign: '',
        title: '求推荐靠谱的 有格调的情侣装店铺？',
        subTitle: '我来给你们种草啦～一、已删除（多人表示质量不好）二、disoo旗舰店这家情侣装真的吼吼好呀～而且都不贵哦，基本100元上下就能搞定一套～三、男左女右即使这家很多都是同款不同色的卫衣，但我也依然觉得好看。',
        greatCount: 9991,
        discussCount: 321,
      ),
      _RecommandModel(
        iconUrl: 'assets/images/main_recommand/charlie.png',
        detailImageUrl: '',
        username: 'CHARLIE',
        userSign: '超过7W的用户关注了TA',
        title: '开锁公司怎么确保让他们开锁的不是小偷？',
        subTitle: '看脸色。按我想，如果有旁证还大费周章半天都不急不慌表现正常的，你是小偷也可以，就是不如转行别白瞎你的演技。好多年前，我在某大城市（不是铁岭）上班租的房子还不错，然后我哥们一把年纪终于吃了嫩草，旅行结婚过来我的城市，正好我不在',
        greatCount: 1623,
        discussCount: 54,
      ),
      _RecommandModel(
        iconUrl: 'assets/images/main_recommand/chengge.png',
        detailImageUrl: 'assets/images/main_recommand/detail_2.png',
        username: '成哥',
        userSign: '',
        title: '为什么有些工程制图老师不允许学生用自动铅笔画图？',
        subTitle: '很多答案没说到点子上，不管什么铅笔，自动的，手动的，镶钻的，钛合金的，英国皇家注册工程师专用9999一支的，都有一个致命的缺陷。只要是铅笔都是容易涂改难以复制，有这两样缺陷必然不能用于工程制图。',
        greatCount: 2453,
        discussCount: 194,
      ),
    ];
  }
}
