import 'package:flutter/material.dart';

class MemberLectureViewModel {
  State state;

  List<BookGoodModel> bookList;
  List<CategoryModel> categoryList;
  CategoryModel selectCategory;
  bool isComprehensiveViewExpand; // 综合下拉框
  bool isShiftViewExpand; // 筛选下拉框

  MemberLectureViewModel.init({
    this.state,
  }) {
    bookList = BookGoodModel.test();
    categoryList = CategoryModel.test();
    isComprehensiveViewExpand = false;
    isShiftViewExpand = false;
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

class CategoryModel {
  String title;

  CategoryModel({
    this.title,
  });

  CategoryModel.fromJson(Map json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    Map json = Map();
    json['title'] = title;
    return json;
  }

  static List<CategoryModel> test() {
    return [
      CategoryModel(title: '全部分类'),
      CategoryModel(title: '科学'),
      CategoryModel(title: '前沿'),
      CategoryModel(title: '财商'),
      CategoryModel(title: '文学'),
      CategoryModel(title: '艺术'),
      CategoryModel(title: '社科'),
      CategoryModel(title: '成长'),
      CategoryModel(title: '职人'),
      CategoryModel(title: '通关'),
      CategoryModel(title: '乐活'),
      CategoryModel(title: '亲密'),
      CategoryModel(title: '亲子'),
    ];
  }
}
