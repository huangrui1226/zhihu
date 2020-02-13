import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zhihu/config/colos.dart';
import 'package:zhihu/model/category_model.dart';
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
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _ShiftView(viewModel),
                Divider(height: 1, color: Color.fromARGB(255, 244, 245, 246)),
                _CategoryView(viewModel),
                _BookView(viewModel),
              ],
            ),
          ),
          viewModel.type != null ? _ExpandeView(type: viewModel.type, viewModel: viewModel) : Container(),
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
    viewModel.isComprehensiveViewExpand = !viewModel.isComprehensiveViewExpand;
    viewModel.type = viewModel.isComprehensiveViewExpand == true ? ExpandViewType.comprehensive : null;
    viewModel.state.setState(() {});
  }

  onShiftClick() {
    viewModel.isShiftViewExpand = !viewModel.isShiftViewExpand;
    viewModel.type = viewModel.isShiftViewExpand == true ? ExpandViewType.shift : null;
    viewModel.state.setState(() {});
  }

  onCategoryClick() {
    viewModel.isCategoryExpand = !viewModel.isCategoryExpand;
    viewModel.type = viewModel.isCategoryExpand == true ? ExpandViewType.category : null;
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

class _ExpandeView extends StatelessWidget {
  final ExpandViewType type;
  final MemberLectureViewModel viewModel;

  _ExpandeView({
    Key key,
    this.type,
    this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (type) {
      case ExpandViewType.category:
        child = _CategoryDetailView(viewModel: viewModel);
        break;
      case ExpandViewType.comprehensive:
        child = _ComprehensiveDetailView(viewModel: viewModel);
        break;
      case ExpandViewType.shift:
        child = _ShiftDetailView(viewModel: viewModel);
        break;
    }

    return Stack(
      children: <Widget>[
        Positioned(
          top: 40,
          left: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              viewModel.type = null;
              viewModel.isComprehensiveViewExpand = false;
              viewModel.isShiftViewExpand = false;
              viewModel.isCategoryExpand = false;
              viewModel.state.setState(() {});
            },
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: child,
        ),
      ],
    );
  }
}

class _CategoryDetailView extends StatefulWidget {
  final MemberLectureViewModel viewModel;

  _CategoryDetailView({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  __CategoryDetailViewState createState() => __CategoryDetailViewState();
}

class __CategoryDetailViewState extends State<_CategoryDetailView> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 8),
            blurRadius: 4,
          ),
        ],
      ),
      height: 340,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 263,
            child: Container(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: List.generate(widget.viewModel.categoryList.length, (index) {
                  return _cellView(widget.viewModel.categoryList[index], index == selectIndex);
                }),
              ),
            ),
          ),
          Expanded(
            flex: 565,
            child: Container(
              color: Color.fromARGB(255, 245, 246, 247),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: List.generate(widget.viewModel.categoryList[selectIndex].subCategory.length, (index) {
                  return _secondCellView(widget.viewModel.categoryList[selectIndex].subCategory[index]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellView(CategoryModel model, bool isSelected) {
    return GestureDetector(
      onTap: () {
        selectIndex = widget.viewModel.categoryList.indexOf(model);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: 45,
        alignment: Alignment.centerLeft,
        child: Text(model.title, style: TextStyle(fontSize: 15)),
        color: isSelected == true ? Color.fromARGB(255, 245, 246, 247) : Colors.white,
      ),
    );
  }

  Widget _secondCellView(CategoryModel model) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 20),
        height: 45,
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        child: Text(model.title),
      ),
    );
  }
}

class _ComprehensiveDetailView extends StatefulWidget {
  final MemberLectureViewModel viewModel;

  _ComprehensiveDetailView({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  __ComprehensiveDetailViewState createState() => __ComprehensiveDetailViewState();
}

class __ComprehensiveDetailViewState extends State<_ComprehensiveDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 8),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) {
          String title;
          switch (index) {
            case 0:
              title = '综合';
              break;
            case 1:
              title = '最新';
              break;
            case 2:
              title = '最多人感兴趣';
              break;
          }
          return Container(
            height: 50,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(fontSize: 16)),
          );
        }),
      ),
    );
  }
}

class _ShiftDetailView extends StatefulWidget {
  final MemberLectureViewModel viewModel;

  _ShiftDetailView({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  __ShiftDetailViewState createState() => __ShiftDetailViewState();
}

class __ShiftDetailViewState extends State<_ShiftDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 161,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 8),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('盐选会员权益', style: TextStyle(fontSize: 15)),
            alignment: Alignment.centerLeft,
          ),
          Expanded(
            child: Container(
              child: Row(
              children: List.generate(3, (index) {
                List<String> title = ['会员免费', '会员折扣', '会员专享'];
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 246, 247),
                      borderRadius: BorderRadius.circular(15.5),
                    ),
                    width: 81,
                    height: 31,
                    child: Text(title[index], style: TextStyle(
                      color: Colors.black45
                    ),),
                  );
              }),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 246, 247),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 39,
                    alignment: Alignment.center,
                    child: Text(
                      '清空',
                      style: TextStyle(
                        color: goldColor,
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: goldColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 39,
                    alignment: Alignment.center,
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
