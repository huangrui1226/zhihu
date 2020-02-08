import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum FocusViewType {
  all, // 全部
  originate, // 只看原创
  idea, // 只看想法
}

class MainPageFocusView extends StatefulWidget {
  final FocusViewType type;

  MainPageFocusView({Key key, this.type}) : super(key: key);

  @override
  _MainPageFocusViewState createState() => _MainPageFocusViewState();
}

class _MainPageFocusViewState extends State<MainPageFocusView> with TickerProviderStateMixin {
  List<_FocusModel> modelList = _FocusModel.test(10);
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
      color: Color(0xFFF5F5F5),
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              Future.delayed(Duration(seconds: 1)).then((_) {
                // TODO - refresh data
                updateAnim.forward();
                refreshController.refreshCompleted();
              });
            },
            child: ListView(
              shrinkWrap: false,
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

class _CellView extends StatelessWidget {
  final _FocusModel model;

  _CellView({this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.5, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _userView(),
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Text(
              model.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                      model.subTitle,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                () {
                  if (model.detailImageUrl == '') {
                    return Container();
                  } else {
                    return Container(
                      width: 95,
                      height: 66,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.asset(model.detailImageUrl),
                    );
                  }
                }(),
              ],
            ),
          ),
          _infoView(),
        ],
      ),
    );
  }

  Widget _userView() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          // 头像
          Container(
            margin: EdgeInsets.only(right: 9),
            width: 33,
            height: 33,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.5),
              child: Image.asset(model.iconUrl),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    model.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    model.lastGreatTime,
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoView() {
    return Container(
      margin: EdgeInsets.only(left: 2),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            width: 18,
            height: 18,
            child: Image.asset('assets/images/focus_support.png'),
          ),
          Container(
            width: 48,
            child: Text(
              model.greatCount == 0 ? '赞同' : model.greatCount.toString(),
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
            margin: EdgeInsets.only(right: 16),
          ),
          Container(
            margin: EdgeInsets.only(right: 8),
            width: 18,
            height: 18,
            child: Image.asset('assets/images/focus_discuss.png'),
          ),
          Container(
            child: Text(
              model.discussCount == 0 ? '评论' : model.discussCount.toString(),
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
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
              '关注动态已更新',
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

class _FocusModel {
  String iconUrl;
  String detailImageUrl;
  String username;
  String lastGreatTime;
  String title;
  String subTitle;
  int greatCount;
  int discussCount;

  _FocusModel({
    this.iconUrl,
    this.detailImageUrl,
    this.username,
    this.lastGreatTime,
    this.title,
    this.subTitle,
    this.greatCount,
    this.discussCount,
  });

  _FocusModel.fromJson(Map<String, dynamic> json) {
    iconUrl = json['iconUrl'];
    detailImageUrl = json['detailImageUrl'];
    username = json['username'];
    lastGreatTime = json['lastGreatTime'];
    title = json['title'];
    subTitle = json['subTitle'];
    greatCount = json['greatCount'];
    discussCount = json['discussCount'];
  }

  Map<String, dynamic> toJson() {
    Map map = {};
    map['iconUrl'] = iconUrl;
    map['detailImageUrl'] = detailImageUrl;
    map['username'] = username;
    map['lastGreatTime'] = lastGreatTime;
    map['title'] = title;
    map['subTitle'] = subTitle;
    map['greatCount'] = greatCount;
    map['discussCount'] = discussCount;
    return map;
  }

  static List<_FocusModel> test(int count) {
    return [
      _FocusModel(
        iconUrl: 'assets/images/main_focus/linduo.png',
        detailImageUrl: 'assets/images/main_focus/detail_0.png',
        username: '林朵',
        lastGreatTime: '19小时前 · 赞同了文章',
        title: '全国新型冠状病毒肺炎疫情最新动态【持续更新】',
        subTitle: '知乎科学：截至2月3日12:40，全国共确诊新型冠状病毒肺炎17238例（含港澳台地区33例），重症2296例，死亡361例，治愈出院477例；疑似病例21558例',
        greatCount: 106778,
        discussCount: 1083,
      ),
      _FocusModel(
        iconUrl: 'assets/images/main_focus/linduo.png',
        detailImageUrl: '',
        username: '林朵',
        lastGreatTime: '19小时前 · 回答了问题',
        title: '有什么特别扎心的故事吗？',
        subTitle: '《茧中人》by 林朵 清晨，女孩从床上醒来。天气有些凉，但她身上盖的不是被子，而是一圈圈纯白色的丝线，胡乱搭在身上，从锁骨到膝盖，有些地方厚，有些地方薄',
        greatCount: 101,
        discussCount: 7,
      ),
      _FocusModel(
        iconUrl: 'assets/images/main_focus/beidouxing.png',
        detailImageUrl: '',
        username: '北斗星',
        lastGreatTime: '23小时前 · 回答了问题',
        title: '父亲今年未满50，母亲未满49，可以购买什么合适的保险，家庭收入并不高？',
        subTitle: '重疾和寿险配置意义不大？接近50岁或甚至超过50岁的中老年人不太适合配置重疾险了。费用昂贵导致保障杠杆偏低，保障额度偏度导致保障不足，失去抵御大病造成经济风险的作用，失去作用的保障花费不菲的情况就显得失去了意义。',
        greatCount: 1,
        discussCount: 0,
      ),
      _FocusModel(
        iconUrl: 'assets/images/main_focus/tiaowu.png',
        detailImageUrl: '',
        username: '跳舞',
        lastGreatTime: '1天前 · 回答了问题',
        title: '如果跳舞、香蕉、烽火、唐三、土豆、猫腻等网络作家回到金庸、古龙那个年代，能否在销量上一较高下？',
        subTitle: '明确的说：我不配。就这样。PS：能不能别再搞这种搞事情引战的问题了？网文自己都从来没敢说自己要挑战超越前辈大师，偏有些人总喜欢搞这种引战制造戾气的话题',
        greatCount: 5540,
        discussCount: 211,
      ),
      _FocusModel(
        iconUrl: 'assets/images/main_focus/beidouxing.png',
        detailImageUrl: 'assets/images/main_focus/detail_1.png',
        username: '北斗星',
        lastGreatTime: '2天前 · 回答了问题',
        title: '重疾险怎么选？',
        subTitle: '看了下题主的问题描述，建议在选择重疾险时尽量先贴合产品本身来看是否值得选择。这样也是比较贴合本题的问题：重疾险怎么选？重疾险到底有什么用？我之所以把这个问题放在第一条，是因为这是一个非常关键而又严肃的问题。',
        greatCount: 0,
        discussCount: 0,
      ),
      _FocusModel(
        iconUrl: 'assets/images/main_focus/example_user_logo.png',
        detailImageUrl: '',
        username: 'TapTap',
        lastGreatTime: '4天前 · 发表了文章',
        title: '控制、收容、保护——浅谈SCP基金会及其衍生作品',
        subTitle: '文｜正义的大脸喵幻想文学作为文学创作题材的重要分支，拥有悠久的历史和广泛的受众。上到各类神话中的奇珍异兽，下到小说电影中的魔法生物，我们总是被作者天马行空的脑洞折服。',
        greatCount: 14,
        discussCount: 8,
      ),
    ];
  }
}
