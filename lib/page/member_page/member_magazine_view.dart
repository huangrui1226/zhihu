import 'package:flutter/material.dart';

String base = 'assets/images/member/member_magazine/';

class MemberMagazineView extends StatefulWidget {
  static String rName = 'MemberMagazineView';

  @override
  _MemberMagazineViewState createState() => _MemberMagazineViewState();
}

class _MemberMagazineViewState extends State<MemberMagazineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _BannerView(),
        ],
      ),
    );
  }
}

class _BannerView extends StatelessWidget {
  double ratio = 768 / 200;
  double margin = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin),
      child: AspectRatio(
        aspectRatio: ratio,
        child: Image.asset(base + 'banner_image.png'),
      ),
    );
  }
}

class _ArticleModel {
  String title;
  String subTitle;
  String from; // 文章出处
  String image;
  int agreeCount;
  int discussCount;

  _ArticleModel({
    this.title,
    this.subTitle,
    this.from,
    this.image,
    this.agreeCount,
    this.discussCount,
  });

  _ArticleModel.fromJson(Map json) {
    title = json['title'];
    subTitle = json['subTitle'];
    from = json['from'];
    image = json['image'];
    agreeCount = json['agreeCount'];
    discussCount = json['discussCount'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    json['subTitle'] = subTitle;
    json['from'] = from;
    json['image'] = image;
    json['agreeCount'] = agreeCount;
    json['discussCount'] = discussCount;
    return json;
  }

  static List<_ArticleModel> test() {
    return [
      _ArticleModel(
        title: '越建越多的图书馆，真的不适合读书',
        from: '东南西北 2019年21期',
        image: base + 'article_image_0.png',
      ),
      _ArticleModel(
        title: '十大恶性传染病',
        subTitle: '细菌、病毒、寄生虫也可以席卷城镇，造成大规模死亡，击垮伟大的领袖和思想家。并在此之后改变人类的政治、卫生和经济状况。',
        from: '科学大观园 2019年23期',
        image: base + 'article_image_1.png',
      ),
      _ArticleModel(
        title: '病毒视角',
        subTitle: '病原体作为相对简单的生命形式，尤其是病毒，简单到自己不能进行任何代谢过程，是如何在漫长的进化中留存下来，并发展出如此强大的杀伤力的？',
        from: '科学大观园 2019年23期',
        image: base + 'article_image_2.png',
      ),
      _ArticleModel(
        title: '永不停歇的疫战',
        subTitle: '可以说，人类的历史就是与传染病斗争的历史，我国政府一直非常重视传染病防治，在战胜疾病的道路上，我国医学科学家一直在努力。',
        from: '科学大观园 2019年23期',
        image: base + 'article_image_3.png',
      ),
      _ArticleModel(
        title: '"救命神器"AED',
        subTitle: '在红十字会等相关机构以及团体、企业、志愿者的助力下，我国的AED普及率和知晓程度正在逐年提升',
        from: '科学大观园 2019年24期',
        image: base + 'article_image_4.png',
      ),
      _ArticleModel(
        title: '第一批住进养老院的90后',
        from: '东西南北 2019年21期',
        image: base + 'article_image_5.png',
      ),
      _ArticleModel(
        title: '世界想摆脱美元，可以吗？',
        subTitle: '伴随着美元的「武器化」，美国挥舞着美元大棒不断对一些经济体实施金融制裁，与之相矛盾的景象出现了——处于对美元的忌惮，全球各国出现了蔚为壮观的「去美元化」行动',
        image: base + 'article_image_6.png',
        agreeCount: 1,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '市长们的钱袋，靠什么来补？',
        subTitle: '2019年，全国300城市土地出让金总额50294亿元，同比增加19%。这是否意味着，市长们越来越离不开「土地财政」?',
        image: base + 'article_image_7.png',
        agreeCount: 1,
      ),
      _ArticleModel(
        title: '庄严食肉者',
        subTitle: '回到文明的源头，我们就能更好的理解这种遗传性的庄严。中国传统文化，定型于贵族制时代的尾声，打着深深的等级制烙印，即使是一桌子菜，也有一个主从关系。',
        from: '南风窗 2020年02期',
        image: base + 'article_image_8.png',
      ),
      _ArticleModel(
        title: '燃烧的大中东，失控的螺旋？',
        subTitle: '伊朗向伊拉克两个美军基地发射了十多枚弹道导弹，因美方有预警而未造成任何人员伤亡，但也算部分完成了哈梅内伊的「报复」心愿，特朗普趁机呼吁和平。',
        from: '南风窗 2020年02期',
        image: base + 'article_image_9.png',
      ),
      _ArticleModel(
        title: '狼的面部表情？',
        from: '大自然探索 2020年02期',
        image: base + 'article_image_10.png',
      ),
      _ArticleModel(
        title: '原味许晴',
        subTitle: '在性格问题上放轻松了，在年龄问题上放的开了，于是有了现在的「原汁原味」的许晴。',
        from: '南风窗 2020年02期',
        image: base + 'article_image_11.png',
      ),
      _ArticleModel(
        title: '帝国遗梦前苏联地下的别样风景',
        image: base + 'article_image_12.png',
        agreeCount: 16,
        discussCount: 6,
      ),
      _ArticleModel(
        title: '30个研究领域第一名 这么看 2020年投资机会',
        subTitle: '核心资产在哪儿？5G该怎么投？集合含金量最高、最新鲜、最热辣的投资观点，覆盖科技、金融、制造、消费、能源与材料、总量研究30个研究领域，为您一一呈现。',
        image: base + 'article_image_13.png',
        agreeCount: 13,
      ),
      _ArticleModel(
        title: '「超级印钞机」是如何炼成的',
        subTitle: '李佳琪像一个超级印钞机，吞进海量流量，吐出大笔销量，这个男人真的有「毒」！',
        image: base + 'article_image_14.png',
        agreeCount: 8,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '网上买保险靠谱吗',
        subTitle: '无论是线上买还是线下买保险，最主要的还是看保险合同的保障内容。只要渠道正规，就可以在保险公司官网查到其合作的互联网保险平台，也可以去中国保险协会官网查询保险产品的备案信息。',
        image: base + 'article_image_15.png',
        agreeCount: 3,
      ),
      _ArticleModel(
        title: '今天不想定投，所以才去定投',
        subTitle: '定投是场漫长的修行，在5年，8年，10年甚至更长的时间里，只要你想，停止的借口无处不在。莫被这些借口迷惑，打倒。',
        image: base + 'article_image_16.png',
        agreeCount: 4,
      ),
      _ArticleModel(
        title: '互联网医院靠谱吗',
        image: base + 'article_image_17.png',
        agreeCount: 3,
      ),
      _ArticleModel(
        title: '生活在南极，我真的太「南」了',
        subTitle: '在南极辽阔的天空，广袤的冰原以及深邃的海洋中，无数生命顽强生存了下来，并不断繁衍生息',
        image: base + 'article_image_18.png',
        agreeCount: 4,
      ),
      _ArticleModel(
        title: '家暴：影视文化堪为解药',
        subTitle: '精神控制不是一夜之间发生的，早期阶段，它通常以施暴者的魅力、痴情和浪漫情调为保护色。',
        image: base + 'article_image_19.png',
        agreeCount: 6,
      ),
      _ArticleModel(
        title: '全球最大上市公司，为何诞生在本地？',
        subTitle: '沙特阿美IPO，意味着沙特开始谋求经济转型，这得到了海湾国家的配合。但由于种种原因，西方基金和银行对阿美股票缺乏兴趣。',
        image: base + 'article_image_20.png',
        agreeCount: 4,
      ),
      _ArticleModel(
        title: '纳粹灭绝营中的犹太奴工',
        subTitle: '工作队中的囚犯差异很大，各有特点，每个人的智力、道德观、性格倾向都有所不同，唯一的共同点就是他们的犹太血统。',
        image: base + 'article_image_21.png',
        agreeCount: 2,
      ),
      _ArticleModel(
        title: '舌尖上的川透力',
        image: base + 'article_image_22.png',
        agreeCount: 30,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '人们为什么仍在读路遥',
        subTitle: '很多评论家都认为，只要城乡二元结构还存在，只要农村青年和小城青年跨越鸿沟的梦想还在，《平凡的世界》就不会过时。',
        image: base + 'article_image_23.png',
        agreeCount: 41,
        discussCount: 6,
      ),
      _ArticleModel(
        title: '如果「范闲」是一台车，那么他将挑战的是运动',
        image: base + 'article_image_24.png',
        discussCount: 1,
      ),
      _ArticleModel(
        title: '中国女排，世界第一',
        subTitle: '虽然2019年不是体育「大年」，但故事依然精彩，让每个国人都深刻感受到了体育的魅力。除了女排姑娘们的骄人战绩，中国体育还有很多高光时刻',
        image: base + 'article_image_25.png',
        agreeCount: 2,
        discussCount: 4,
      ),
      _ArticleModel(
        title: '国产电影：冰冷的是火',
        subTitle: '如此看来，2019年的电影市场着实有趣——三大黄金档的三种爆款：科幻、国漫、主旋律，背后都有着多年的积淀和颠覆',
        image: base + 'article_image_26.png',
        agreeCount: 8,
        discussCount: 2,
      ),
      _ArticleModel(
        title: '响水爆炸之后：「宁可毒死，不要穷死」可以休矣',
        subTitle: '彻底关闭响水化工园区，是几经惨痛后的「断腕」抉择，也是对此前「要GDP，不要生态」畸形发展观的矫正',
        image: base + 'article_image_27.png',
        agreeCount: 7,
        discussCount: 3,
      ),
      _ArticleModel(
        title: '恐怖主义全球阴影挥之不去',
        subTitle: '在国际反恐斗争进入治乱新周期，如何反恐、靖乱和治乱，成为摆在全世界面前的全球安全治理难题。',
        image: base + 'article_image_28.png',
        agreeCount: 12,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '疑心引发的杀妻血案',
        image: base + 'article_image_29.png',
        agreeCount: 4,
        discussCount: 3,
      ),
      _ArticleModel(
        title: '恐龙究竟是如何灭绝的',
        subTitle: '《美国科学院院刊》最近刊发的一份最新研究报告显示，埋藏在墨西哥近海海底巨大撞击坑的岩石「记录」了小行星撞击地球那个地球生命史上「糟糕」的日子',
        image: base + 'article_image_30.png',
        agreeCount: 16,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '冷空气带来的传言让您「感冒」了吗',
        subTitle: '冷空气来袭，一些有鼻子有眼的冬季「注意事项」也流传开来，真相到底是什么？',
        image: base + 'article_image_31.png',
        agreeCount: 1,
      ),
      _ArticleModel(
        title: '《少年的你》热播',
        subTitle: '一部电影，当然不可能从根本上扭转局面。但只要能反映一个无法忽视的问题，能够引起全社会的关注和思考，就够了。',
        image: base + 'article_image_32.png',
        agreeCount: 13,
        discussCount: 2,
      ),
      _ArticleModel(
        title: '京张高铁，从「人」到「大」',
        image: base + 'article_image_33.png',
        agreeCount: 11,
        discussCount: 3,
      ),
      _ArticleModel(
        title: '「过气」的芭比和维秘',
        subTitle: '天气渐渐冷了，连堪称年底最隆（好）重（看）的国际时尚盛会也停办。11月22日，维秘的母公司L Brands首席财务官兼执行副总裁Stuart Burgdoerfer正式2019年维密秀取消。',
        image: base + 'article_image_34.png',
        agreeCount: 3,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '给中印关系加点人文酱料',
        subTitle: '2020年是「中印人文交流年」，双方将举办70场活动庆祝两国建交70周年。除此之外呢？',
        image: base + 'article_image_35.png',
        agreeCount: 2,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '比翼鸳鸯成双堕落',
        subTitle: '2019年10月29日，四川省广安市中级人民法院对外公布何鹏受贿案一审判决结果，四川省纪委驻环境保护厅原纪检组长何鹏受贿318.91万元',
        image: base + 'article_image_36.png',
        agreeCount: 2,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '年轻人爱分期',
        subTitle: '11月18日，在美国上市的消费信贷公司乐信发布了2019年第三季度的财报，营业收入、净利润大涨，活跃用户数猛增。',
        image: base + 'article_image_37.png',
        agreeCount: 2,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '中国人，缺一堂死亡课',
        image: base + 'article_image_38.png',
        agreeCount: 41,
        discussCount: 15,
      ),
      _ArticleModel(
        title: '叔本华：正直还是伪善',
        subTitle: '阿图尔·叔本华（德语: Arthur schopenhauer, 1788.2.22——1860.9.21），著名德国哲学家，唯意志论注意的开创者。',
        image: base + 'article_image_39.png',
        agreeCount: 15,
        discussCount: 1,
      ),
      _ArticleModel(
        title: '二战德军回忆：恐惧死亡的日子',
        subTitle: '盖伊·萨杰，1942年以17岁之身入伍，次年进入东线德军最精锐的大德意志师，参加了德军与苏军的几乎所有重要会战。',
        image: base + 'article_image_40.png',
        agreeCount: 10,
        discussCount: 2,
      ),
      _ArticleModel(
        title: '直播时代的无节制消费',
        image: base + 'article_image_41.png',
        agreeCount: 11,
        discussCount: 2,
      ),
      _ArticleModel(
        title: '快乐印度：366天都在过节',
        subTitle: '在印度，哪一天才是「新年」？这个简单的问题却很难回答。印度各地区，各民族都有自己的年历，也就有了各自不同的新年。',
        image: base + 'article_image_42.png',
        agreeCount: 1,
      ),
      _ArticleModel(
        title: '年度最佳杂志的编辑是这样说的',
        subTitle: '能够形成这样的杂志个性，还产生这样的文字影响力，与编辑们毒辣的眼光是分不开的。',
        image: base + 'article_image_43.png',
        agreeCount: 3,
      ),
      _ArticleModel(
        title: '如果卡夫卡活到100岁',
        subTitle: '卡夫卡的一生，刚好处在中欧犹太人走向灭亡的最后时刻。他的生命太短，所以他躲过了灾难的降临，但他有限的生命也足以让他体验到灾难形成的全过程。',
        image: base + 'article_image_44.png',
        agreeCount: 6,
      ),
    ];
  }
}
