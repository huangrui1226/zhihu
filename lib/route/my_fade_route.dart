import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhihu/page/main_page/search_view/main_search_page.dart';

class MyFadeRoute extends PageRoute {
  MyFadeRoute(
    WidgetBuilder builder, {
    RouteSettings settings,
  }) : super(
          settings: settings,
          fullscreenDialog: false,
        );

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => 'MyFadeRoute';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MainSearchPage();
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 1000);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
