import 'package:flutter/material.dart';
import 'package:zhihu/page/main_page/search_view/main_search_view.dart';

class MainSearchPage extends StatefulWidget {
  static String rName = 'MainSearchPage';

  @override
  _MainSearchPageState createState() => _MainSearchPageState();
}

class _MainSearchPageState extends State<MainSearchPage> with TickerProviderStateMixin {
  FocusNode _focusNode;
  TextEditingController _controller;
  List<_CategoryModel> _modelList;
  TabController _tabController;

  @override
  void initState() {
    _modelList = _CategoryModel.test();
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _tabController = TabController(
      length: _modelList.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: top),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _AppBar(focusNode: _focusNode, controller: _controller),
            _CategoryView(modelList: _modelList, controller: _tabController),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: List.generate(6, (index) {
                  List<RecommandModel> list;
                  switch (index) {
                    case 0:
                      list = RecommandModel.hotList();
                      break;
                    case 1:
                      list = RecommandModel.diseaseList();
                      break;
                    case 2:
                      list = RecommandModel.movieList();
                      break;
                    case 3:
                      list = RecommandModel.digitList();
                      break;
                    case 4:
                      list = RecommandModel.sportList();
                      break;
                    case 5:
                      list = RecommandModel.subList();
                      break;
                  }
                  return MainSearchView(modelList: list);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  _AppBar({
    Key key,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: EdgeInsets.only(right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xFFEFF0F1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 4),
                    child: Icon(Icons.search, size: 20, color: Colors.black38),
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: this.controller,
                        focusNode: this.focusNode,
                        autocorrect: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '搜索知乎内容',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (this.focusNode.hasFocus) {
                this.focusNode.unfocus();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Center(
                child: Text(
                  '取消',
                  style: TextStyle(
                    color: Color(0xFF0087FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final List<_CategoryModel> modelList;
  final TabController controller;

  _CategoryView({
    Key key,
    this.modelList,
    this.controller,
  }) : super(key: key);

  @override
  __CategoryViewState createState() => __CategoryViewState();
}

class __CategoryViewState extends State<_CategoryView> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.modelList.length, (index) {
          _CategoryModel model = widget.modelList[index];
          TextStyle selectStyle = TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          );
          TextStyle unSelectStyle = TextStyle(
            color: Colors.black54,
            fontSize: 15,
          );

          return GestureDetector(
            onTap: () {
              widget.controller.index = index;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: index == widget.controller.index ? Color(0xFFF3F4F5) : Colors.white,
              ),
              child: Center(
                child: Text(
                  model.title,
                  style: index == widget.controller.index ? selectStyle : unSelectStyle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _CategoryModel {
  String title;

  _CategoryModel({
    this.title,
  });

  _CategoryModel.fromJson(Map json) {
    this.title = json['title'];
  }

  Map toJson() {
    Map json = Map();
    json['title'] = title;
    return json;
  }

  static List<_CategoryModel> test() {
    return [
      _CategoryModel(title: '热搜'),
      _CategoryModel(title: '抗击肺炎'),
      _CategoryModel(title: '影院'),
      _CategoryModel(title: '数码'),
      _CategoryModel(title: '体育'),
      _CategoryModel(title: '百科'),
    ];
  }
}

class RecommandModel {
  String title;
  String subTitle;

  RecommandModel({
    this.title,
    this.subTitle,
  });

  RecommandModel.fromJson(Map json) {
    title = json['title'];
    subTitle = json['subTitle'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    json['subTitle'] = subTitle;
    return json;
  }

  static List<RecommandModel> hotList() {
    return [
      RecommandModel(
        title: '冰箱那个牌子好',
        subTitle: '大家都在搜',
      ),
      RecommandModel(
        title: '全国确诊24363例',
        subTitle: '最新疫情数据',
      ),
      RecommandModel(
        title: '湖北红会3领导被问责',
        subTitle: '专职副会长被免',
      ),
      RecommandModel(
        title: '右正丽',
        subTitle: '新冠病毒并非人造',
      ),
      RecommandModel(
        title: '武汉病毒研究所',
        subTitle: '申请治疗新冠肺炎专利',
      ),
      RecommandModel(
        title: '李兰娟团队发布重大抗病毒研究成果',
        subTitle: '希望来了？',
      ),
      RecommandModel(
        title: '男子武汉返乡却谎称菲律宾回来',
        subTitle: '密切接触4000人',
      ),
      RecommandModel(
        title: '武汉方舱医院',
        subTitle: '连夜开辟',
      ),
    ];
  }

  static List<RecommandModel> diseaseList() {
    return [
      RecommandModel(
        title: '李兰娟团队最新成果',
        subTitle: '阿比朵儿、达芦那韦',
      ),
      RecommandModel(
        title: '2.1%：全国确诊病例占全国总数的',
        subTitle: '湖北省病死率3.1%',
      ),
      RecommandModel(
        title: '瑞德西韦发明专利已被注册',
        subTitle: '武汉病毒所发表官方声明',
      ),
      RecommandModel(
        title: '卫建委第五版诊疗方案公布',
        subTitle: '无症状感染者也可能成为',
      ),
      RecommandModel(
        title: '九州通接管武汉红十字会',
        subTitle: '2小时内完成入库分发',
      ),
      RecommandModel(
        title: '泰国合用药物治疗新冠肺炎',
        subTitle: '感冒和艾滋药物效果良好',
      ),
      RecommandModel(
        title: '感染新型冠状病毒症状',
        subTitle: '如何知道自己是否感染',
      ),
      RecommandModel(
        title: '深圳新增患者为外卖员',
        subTitle: '点外卖会有感染风险吗？',
      ),
    ];
  }

  static List<RecommandModel> movieList() {
    return [
      RecommandModel(
        title: '我的英雄学院',
        subTitle: '原著作者公开辱华？',
      ),
      RecommandModel(
        title: '跟着电影看世界',
        subTitle: '一次看个够',
      ),
      RecommandModel(
        title: '北灵少年志之大主宰',
        subTitle: '王源演绎大男主牧尘',
      ),
      RecommandModel(
        title: '美利坚女士',
        subTitle: '从乡村霉到美国小姐',
      ),
      RecommandModel(
        title: '锦衣之下',
        subTitle: '锦衣卫带薪恋爱',
      ),
      RecommandModel(
        title: '九号秘事 第五季',
        subTitle: '英式黑色幽默代表作',
      ),
      RecommandModel(
        title: '爱情公寓5',
        subTitle: '胡一菲房型设计方案',
      ),
      RecommandModel(
        title: '新世界',
        subTitle: '杀手小红袄是谁？',
      ),
    ];
  }

  static List<RecommandModel> digitList() {
    return [
      RecommandModel(
        title: '用AI量体温？',
        subTitle: '对疫情防控有哪些作用？',
      ),
      RecommandModel(
        title: '戴尔XPS 13 14999元',
        subTitle: '国行售价定价高了吗？',
      ),
      RecommandModel(
        title: '黑莓手机将停产',
        subTitle: '2020年8月停售',
      ),
      RecommandModel(
        title: '远程办公第三天',
        subTitle: '你适应了吗？',
      ),
      RecommandModel(
        title: '有哪些远程办公软件？',
        subTitle: '对通信行业有何挑战？',
      ),
      RecommandModel(
        title: '2019国内手机出货量',
        subTitle: '华为增长，小米苹果下降',
      ),
      RecommandModel(
        title: '有哪些中二的Wi-Fi名？',
        subTitle: '起名那些事儿',
      ),
      RecommandModel(
        title: 'iPhone 11相机DxO得分仅109',
        subTitle: '与华为P20 Pro相当',
      ),
    ];
  }

  static List<RecommandModel> sportList() {
    return [
      RecommandModel(
        title: '卡佩拉加盟老鹰',
        subTitle: '四万交易达成',
      ),
      RecommandModel(
        title: '湖人27分轻取马刺',
        subTitle: '詹姆斯36+9',
      ),
      RecommandModel(
        title: '暴雪回应《魔兽重制版》',
        subTitle: '我们希望玩家感受原汁原味的魔兽',
      ),
      RecommandModel(
        title: '莫兰特回怼库里',
        subTitle: '公开不满伊戈达拉',
      ),
      RecommandModel(
        title: '锡安20分不敌雄鹿',
        subTitle: '字母哥34+17',
      ),
      RecommandModel(
        title: '梅西回应阿比达尔',
        subTitle: '「你说谁不努力？」',
      ),
      RecommandModel(
        title: '登贝莱赛季报销',
        subTitle: '遭遇肌腱撕裂',
      ),
      RecommandModel(
        title: '快船三分险胜马刺',
        subTitle: '双德空砍53分',
      ),
    ];
  }

  static List<RecommandModel> subList() {
    return [
      RecommandModel(
        title: '什么是「冠状病毒」',
        subTitle: '是如何感染的',
      ),
      RecommandModel(
        title: '睡眠呼吸暂停综合症',
        subTitle: '打呼噜到底正不正常',
      ),
      RecommandModel(
        title: '极简主义是什么风格',
        subTitle: '有着少即是多的理念',
      ),
      RecommandModel(
        title: '尼斯湖水怪的真相',
        subTitle: '堪称世上最强「照骗」',
      ),
      RecommandModel(
        title: '社会心理学',
        subTitle: '社会影响塑造行为',
      ),
      RecommandModel(
        title: '社交焦虑障碍',
        subTitle: '孤独者更擅社交吗',
      ),
      RecommandModel(
        title: '「立春」至',
        subTitle: '万物开始复苏',
      ),
      RecommandModel(
        title: '什么是「赛博朋克」',
        subTitle: 'high tech, low life',
      ),
    ];
  }
}
