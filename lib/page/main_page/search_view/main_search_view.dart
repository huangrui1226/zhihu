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
    int length = modelList.length ~/ 2;
    return Container(
      child: Column(
        children: List.generate(length, (index) {
          return Container(
            height: 60,
            child: Row(
              children: List.generate((index + 1) * 2 <= modelList.length ? 2 : 1, (i) {
                RecommandModel model = modelList[index * 2 + i];
                return Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12, right: 8),
                          child: Text(
                            '${index * 2 + i + 1}',
                            style: TextStyle(
                              color: (index*2+i+1) < 4 ? Color(0xFFFB980C) : Colors.black38,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  model.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                child: Text(
                                  model.subTitle,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
