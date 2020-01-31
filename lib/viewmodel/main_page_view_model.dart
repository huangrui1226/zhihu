import 'package:flutter/material.dart';

class MainPageViewModel {
  bool isExpanded = false; // 关注按钮下方的View
  AnimationController expandAnim; // 展开关注按钮下方View的动画
  TabController controller;
  void Function() refresh;

  MainPageViewModel({
    this.isExpanded = false,
    this.expandAnim,
    this.refresh,
    this.controller,
  }) {
    this.expandAnim.addListener(() {
      refresh();
    });
  }

  dispose() {
    this.expandAnim.dispose();
    this.controller.dispose();
  }

  onFocusClicked() {
    isExpanded = !isExpanded;
    if (isExpanded == true) {
      expandAnim.forward();
    } else {
      expandAnim.reverse();
    }
  }
}
