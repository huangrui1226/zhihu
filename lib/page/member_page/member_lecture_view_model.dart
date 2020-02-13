import 'package:flutter/material.dart';
import 'package:zhihu/model/category_model.dart';

enum ExpandViewType {
  category,
  comprehensive,
  shift,
}

class MemberLectureViewModel {
  State state;

  List<BookGoodModel> bookList;
  List<CategoryModel> categoryList;
  CategoryModel selectCategory;
  ExpandViewType type; // 下拉框类型

  bool _isCategoryExpand; // 分类下拉框
  bool get isCategoryExpand {
    return _isCategoryExpand;
  }
  set isCategoryExpand(bool val) {
    _isCategoryExpand = val;
    if (_isCategoryExpand == true) {
      _isComprehensiveViewExpand = false;
      _isShiftViewExpand = false;
    }
  }

  bool _isComprehensiveViewExpand; // 综合下拉框
  bool get isComprehensiveViewExpand {
    return _isComprehensiveViewExpand;
  }
  set isComprehensiveViewExpand(bool val) {
    _isComprehensiveViewExpand = val;
    if (val == true) {
      _isShiftViewExpand = false;
      _isCategoryExpand = false;
    }
  }

  bool _isShiftViewExpand; // 筛选下拉框
  bool get isShiftViewExpand {
    return _isShiftViewExpand;
  }
  set isShiftViewExpand(bool val) {
    _isShiftViewExpand = val;
    if (val == true) {
      _isComprehensiveViewExpand = false;
      _isCategoryExpand = false;
    }
  }

  MemberLectureViewModel.init({
    this.state,
  }) {
    bookList = BookGoodModel.test();
    categoryList = CategoryModel.categoryList();
    _isComprehensiveViewExpand = false;
    _isShiftViewExpand = false;
    isCategoryExpand = false;
  }
}

class BookGoodModel {
  String imagePaht;
  String title;
  String author;
  String subTitle;
  double price;
  bool isFree;

  BookGoodModel({
    this.imagePaht,
    this.title,
    this.author,
    this.subTitle,
    this.price,
    this.isFree,
  });

  BookGoodModel.fromJson(Map json) {
    imagePaht = json['imagePath'];
    title = json['title'];
    author = json['author'];
    subTitle = json['subTitle'];
    price = json['price'];
    isFree = json['isFree'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['imagePath'] = imagePaht;
    json['title'] = title;
    json['author'] = author;
    json['subTitle'] = subTitle;
    json['price'] = price;
    json['isFree'] = isFree;
    return json;
  }

  static List<BookGoodModel> test() {
    String base = 'assets/images/member/member_reading/';
    return [
      BookGoodModel(
        imagePaht: base + 'book_good_image_0.png',
        title: '笑场',
        author: '李诞',
        subTitle: '高手从来不拔刀，真僧只说家常事',
        price: 17.99,
        isFree: true,
      ),
      BookGoodModel(
        imagePaht: base + 'book_good_image_1.png',
        title: 'Linux命令行与shell脚本编程大全',
        author: 'Richard Blum',
        subTitle: '一本关于Linus命令行与shell脚本编程的书',
        price: 54.99,
        isFree: false,
      ),
      BookGoodModel(
        imagePaht: base + 'book_good_image_2.png',
        title: '白话区块链',
        author: '蒋勇',
        subTitle: '涵盖区块链底层技术，典型业务场景',
        price: 25,
        isFree: true,
      ),
      BookGoodModel(
        imagePaht: base + 'book_good_image_3.png',
        title: '聪明人用方格笔记本',
        author: '高桥政史',
        subTitle: '开始新的笔记之路，开启新的人生旅途',
        price: 17.99,
        isFree: true,
      ),
      BookGoodModel(
        imagePaht: base + 'book_good_image_4.png',
        title: 'Nginx完全开发指南：使用C、C++和OpenResty',
        author: '罗剑锋',
        subTitle: '一个近乎「全能」的服务器软件开发书',
        price: 58.8,
        isFree: true,
      ),
      BookGoodModel(
        imagePaht: base + 'book_good_image_5.png',
        title: '浴缸里的惊叹：256道让你恍然大悟的趣题',
        author: '顾森',
        subTitle: '一个疯狂数学爱好者的数学笔记。',
        price: 18,
        isFree: true,
      ),
    ];
  }
}