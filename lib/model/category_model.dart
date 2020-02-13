import 'package:flutter/foundation.dart';

class CategoryModel {
  String title;
  List<CategoryModel> subCategory;

  CategoryModel({this.title, this.subCategory,});

  CategoryModel.fronJson(Map json) {
    title = json['title'];
    subCategory = json['subCategory'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    json['subCategory'] = subCategory;
  }

  static List<CategoryModel> categoryList() {
    return [
      CategoryModel(title: '全部分类', subCategory: _allCategory()),
      CategoryModel(title: '科学', subCategory: _science()),
      CategoryModel(title: '前沿', subCategory: fore()),
      CategoryModel(title: '财商', subCategory: finance()),
      CategoryModel(title: '文学', subCategory: fiction()),
      CategoryModel(title: '艺术', subCategory: art()),
      CategoryModel(title: '社科', subCategory: sociaty()),
      CategoryModel(title: '成长', subCategory: grow()),
      CategoryModel(title: '职人', subCategory: occupation()),
      CategoryModel(title: '通关', subCategory: exam()),
      CategoryModel(title: '乐活', subCategory: life()),
      CategoryModel(title: '亲密', subCategory: close()),
      CategoryModel(title: '亲子', subCategory: child()),
    ];
  }

  static List<CategoryModel> _allCategory() {
    return [
      CategoryModel(title: '全部分类'),
    ];
  }

  static List<CategoryModel> _science() {
    return [
      CategoryModel(title: '全部科学'),
      CategoryModel(title: '百科全说'),
      CategoryModel(title: '天文地理'),
      CategoryModel(title: '自然生物'),
      CategoryModel(title: '工业技术'),
      CategoryModel(title: '数学'),
      CategoryModel(title: '化学'),
    ];
  }

  static List<CategoryModel> fore() {
    return [
      CategoryModel(title: '全部前沿'),
      CategoryModel(title: '互联网思维'),
      CategoryModel(title: '数据分析与云计算'),
      CategoryModel(title: '人工智能'),
      CategoryModel(title: '编程开发'),
      CategoryModel(title: '通信与安全'),
      CategoryModel(title: '产品与运营'),
      CategoryModel(title: '品牌营销'),
      CategoryModel(title: '设计创意'),
    ];
  }

  static List<CategoryModel> finance() {
    return [
      CategoryModel(title: '全部财商'),
      CategoryModel(title: '经济学通识'),
      CategoryModel(title: '小白学理财'),
      CategoryModel(title: '投融资交易'),
      CategoryModel(title: '财务与税收'),
      CategoryModel(title: '地产交易'),
      CategoryModel(title: '财经小说'),
    ];
  }

  static List<CategoryModel> fiction() {
    return [
      CategoryModel(title: '全部文学'),
      CategoryModel(title: '理论鉴赏'),
      CategoryModel(title: '影视原著'),
      CategoryModel(title: '悬疑推理'),
      CategoryModel(title: '武侠科幻'),
      CategoryModel(title: '神话传说'),
      CategoryModel(title: '中国文学'),
      CategoryModel(title: '日本文学'),
      CategoryModel(title: '外国文学'),
      CategoryModel(title: '历史风云'),
      CategoryModel(title: '人物传记'),
      CategoryModel(title: '散文随笔'),
      CategoryModel(title: '诗词诗赋'),
      CategoryModel(title: '戏剧曲艺'),
    ];
  }

  static List<CategoryModel> art() {
    return [
      CategoryModel(title: '全部艺术'),
      CategoryModel(title: '鉴赏与史论'),
      CategoryModel(title: '音乐'),
      CategoryModel(title: '影视'),
      CategoryModel(title: '美术'),
      CategoryModel(title: '摄影'),
      CategoryModel(title: '其他'),
    ];
  }

  static List<CategoryModel> sociaty() {
    return [
      CategoryModel(title: '全部社科'),
      CategoryModel(title: '文化研究'),
      CategoryModel(title: '城市环境'),
      CategoryModel(title: '人文地理'),
      CategoryModel(title: '法律通识'),
      CategoryModel(title: '军事政治'),
      CategoryModel(title: '新闻传播'),
      CategoryModel(title: '语言文字'),
      CategoryModel(title: '哲学/宗教'),
    ];
  }

  static List<CategoryModel> grow() {
    return [
      CategoryModel(title: '全部成长'),
      CategoryModel(title: '心理百科'),
      CategoryModel(title: '心理疗愈'),
      CategoryModel(title: '自我管理'),
      CategoryModel(title: '人际交往'),
      CategoryModel(title: '演讲口才'),
      CategoryModel(title: '思维提升'),
      CategoryModel(title: '名人励志'),
    ];
  }

  static List<CategoryModel> occupation() {
    return [
      CategoryModel(title: '全部职人'),
      CategoryModel(title: '求职与规划'),
      CategoryModel(title: '职场技能'),
      CategoryModel(title: '团队管理'),
      CategoryModel(title: '创业必备'),
      CategoryModel(title: '专业岗位'),
      CategoryModel(title: '职场小说'),
    ];
  }

  static List<CategoryModel> exam() {
    return [
      CategoryModel(title: '全部通关'),
      CategoryModel(title: '专业考试'),
      CategoryModel(title: '高考'),
      CategoryModel(title: '公务员'),
      CategoryModel(title: '考研'),
      CategoryModel(title: '留学'),
      CategoryModel(title: '语言学习'),
    ];
  }

  static List<CategoryModel> life() {
    return [
      CategoryModel(title: '全部乐活'),
      CategoryModel(title: '居家购物'),
      CategoryModel(title: '医疗健康'),
      CategoryModel(title: '时尚美妆'),
      CategoryModel(title: '减肥瘦身'),
      CategoryModel(title: '旅行游玩'),
      CategoryModel(title: '美食烹饪'),
      CategoryModel(title: '休闲娱乐'),
    ];
  }

  static List<CategoryModel> close() {
    return [
      CategoryModel(title: '全部亲密'),
      CategoryModel(title: '青春言情'),
      CategoryModel(title: '恋爱关系'),
      CategoryModel(title: '家庭关系'),
    ];
  }

  static List<CategoryModel> child() {
    return [
      CategoryModel(title: '全部亲子'),
      CategoryModel(title: '产妇早教'),
      CategoryModel(title: '幼儿教育'),
      CategoryModel(title: '亲子关系'),
      CategoryModel(title: '童话绘本'),
    ];
  }
}