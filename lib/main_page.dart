import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static String rName = 'MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(
      length: 4,
      vsync: this,
    );
    controller.addListener(() {
      print('${controller.index}');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(
                  child: GestureDetector(
                    onTap: () {
                      controller.animateTo(0);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Text('关注'),
                          Icon(Icons.arrow_drop_down),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                ),
                Tab(text: '推荐'),
                Tab(text: '热榜'),
                ExpansionPanelList(
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        Color color = isExpanded ? Colors.red : Colors.blue;
                        return Container(
                          width: 32,
                          height: 32,
                          color: color,
                        );
                      },
                      body: Container(
                        height: 32,
                        width: 32,
                        color: Colors.green,
                      ),
                      canTapOnHeader: true,
                    ),
                  ],
                  expansionCallback: (index, isOk) {

                  },
                ),
              ],
              controller: controller,
              labelColor: Colors.black,
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Container(color: Colors.blue),
                  Container(color: Colors.green),
                  Container(color: Colors.red),
                  Container(color: Colors.yellow),
                ],
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.white,
              height: 44,
            ),
          ),
          Container(
            width: 44,
            height: 44,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
