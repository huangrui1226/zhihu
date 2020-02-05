import 'package:flutter/material.dart';

class MainPageViewModel {
  bool isExpanded = false; // 关注按钮下方的View
  AnimationController expandAnim; // 展开关注按钮下方View的动画
  TabController controller;
  void Function() refresh;

  TextStyle selectTabStyle;
  Color selectTabColor;
  TextStyle unSelectTabStyle;
  Color unSelectTabColor;

  MainPageViewModel({
    this.isExpanded = false,
    this.expandAnim,
    this.refresh,
    this.controller,
  }) {
    this.expandAnim.addListener(() {
      refresh();
    });
    this.selectTabColor = Colors.black;
    this.selectTabStyle = TextStyle(
      color: this.selectTabColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    this.unSelectTabColor = Colors.black45;
    this.unSelectTabStyle = TextStyle(
      color: this.unSelectTabColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  dispose() {
    this.expandAnim.dispose();
    this.controller.dispose();
  }

  onFocusClicked() {
    // 如果在其他选项卡，首先切换到'关注'
    if (controller.index != 0) {
      controller.animateTo(0);
    } else {
      isExpanded = !isExpanded;
      if (isExpanded == true) {
        expandAnim.forward();
      } else {
        expandAnim.reverse();
      }
    }
  }

  closeExpandView() {
    isExpanded = false;
    expandAnim.reverse();
  }

  onSearchViewTap() {}
}
