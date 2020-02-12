import 'package:flutter/material.dart';
import 'package:zhihu/config/colos.dart';
import 'package:zhihu/page/member_page/member_lecture_view_model.dart';

double _margin = 20.0;

class MemberLectureView extends StatefulWidget {
  @override
  _MemberLectureViewState createState() => _MemberLectureViewState();
}

class _MemberLectureViewState extends State<MemberLectureView> {
  MemberLectureViewModel viewModel;

  @override
  void initState() {
    viewModel = MemberLectureViewModel.init(state: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _ShiftView(viewModel),
          Divider(height: 1, color: Color.fromARGB(255, 244, 245, 246)),
          _CategoryView(viewModel),
          _BookView(viewModel),
        ],
      ),
    );
  }

  onCategoryClicked(CategoryModel model) {
    viewModel.selectCategory = model;
    setState(() {});
  }
}

class _ShiftView extends StatelessWidget {
  final MemberLectureViewModel viewModel;

  _ShiftView(
    this.viewModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    Color categoryColor;
    if (viewModel.selectCategory == null) {
      title = '全部分类';
      categoryColor = viewModel.isCategoryExpand == true ? goldColor : Colors.black;
    } else {
      if (viewModel.selectCategory.title == '全部分类') {
        title = viewModel.selectCategory.title;
        categoryColor = viewModel.isCategoryExpand == true ? goldColor : Colors.black;
      } else {
        title = '全部' + viewModel.selectCategory.title;
        categoryColor = goldColor;
      }
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 1, left: _margin, right: _margin),
      height: 39,
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: onCategoryClick,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text(title, style: TextStyle(color: categoryColor, fontSize: 15)),
                      Icon(viewModel.isCategoryExpand == true ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: categoryColor),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onComprehensiveClick,
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/member/member_lecture/lecture_comprehensive.png',
                      color: viewModel.isComprehensiveViewExpand == true ? goldColor : Colors.black38,
                      colorBlendMode: BlendMode.overlay,
                      width: 14,
                      height: 14,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(
                        '综合',
                        style: TextStyle(
                          color: viewModel.isComprehensiveViewExpand == true ? goldColor : Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onShiftClick,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/member/member_lecture/lecture_shift.png',
                      color: viewModel.isShiftViewExpand == true ? goldColor : Colors.black38,
                      colorBlendMode: BlendMode.overlay,
                      width: 14,
                      height: 14,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(
                        '筛选',
                        style: TextStyle(
                          color: viewModel.isShiftViewExpand == true ? goldColor : Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onComprehensiveClick() {
    viewModel.isComprehensiveViewExpand = true;
    viewModel.state.setState(() {});
  }

  onShiftClick() {
    viewModel.isShiftViewExpand = true;
    viewModel.state.setState(() {});
  }

  onCategoryClick() {
    viewModel.isCategoryExpand = !viewModel.isCategoryExpand;
    viewModel.state.setState(() {});
  }
}

class _CategoryView extends StatefulWidget {
  final MemberLectureViewModel viewModel;

  _CategoryView(
    this.viewModel, {
    Key key,
  }) : super(key: key);

  @override
  __CategoryViewState createState() => __CategoryViewState();
}

class __CategoryViewState extends State<_CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        children: widget.viewModel.categoryList.map((model) => _cellView(model)).toList(),
      ),
    );
  }

  Widget _cellView(CategoryModel model) {
    Color selectColor = Color.fromRGBO(203, 153, 79, 1.0);

    return GestureDetector(
      onTap: () {
        widget.viewModel.selectCategory = model;
        widget.viewModel.state.setState(() {});
      },
      child: Container(
        height: 30,
        width: 68,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 246, 247),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(model.title, style: TextStyle(color: widget.viewModel.selectCategory == model ? selectColor : Colors.black)),
      ),
    );
  }
}

class _BookView extends StatelessWidget {
  final MemberLectureViewModel viewModel;

  _BookView(
    this.viewModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.5),
      child: Column(
        children: viewModel.bookList.map((model) => _cellView(model)).toList(),
      ),
    );
  }

  Widget _cellView(BookGoodModel model) {
    double ratio = 140 / 186.0;
    EdgeInsetsGeometry padding = EdgeInsets.only(bottom: _margin, left: _margin, right: _margin);
    return Container(
      padding: padding,
      height: 113,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: ratio,
            child: Image.asset(
              model.imagePaht,
//              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  Text(
                    model.author,
                    style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    model.subTitle,
                    style: TextStyle(color: Colors.black38, fontSize: 13, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 245, 246, 247),
                  ),
                  child: Center(
                    child: Text(
                      '¥ ${model.price}',
                      style: TextStyle(
                        color: Color.fromRGBO(203, 153, 79, 1.0),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    model.isFree ? '盐选会员免费' : '',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
