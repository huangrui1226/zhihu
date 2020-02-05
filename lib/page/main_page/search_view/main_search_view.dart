import 'package:flutter/material.dart';
import 'package:zhihu/page/main_page/search_view/main_search_page.dart';

class MainSearchView extends StatelessWidget {
  final List<RecommandModel> modelList;

  MainSearchView({
    Key key,
    this.modelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        children: List.generate(modelList.length, (index) {
          RecommandModel model = modelList[index];
          return Container(
            color: Colors.red,
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(model.title),
                Text(model.subTitle),
              ],
            ),
          );
        }),
      ),
    );
  }
}
