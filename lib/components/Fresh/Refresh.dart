

library scroll_list;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
// import 'package:app/config/iconfont.dart';
// import 'package:app/generated/l10n.dart';
// import 'package:app/config/dimens.dart';
import 'package:app/components/Fresh/RefreshConfig.dart';
part 'Header.dart';
part 'Footer.dart';

class Refresh extends StatefulWidget{
  const Refresh({Key key, this.scrollWidget, this.count, this.onRefresh, this.onLoad, this.emptyWidget}) : super(key: key);

  final int count;
  final Function scrollWidget;
  final Function onRefresh;
  final Function onLoad;
  final Widget emptyWidget;

  @override
  _Refresh createState() => _Refresh();
}

class _Refresh extends State<Refresh> {

  EasyRefreshController _controller;
  ScrollController _scrollController;
  final bool autoRefresh = true;
  final bool reverse = false;
  final Axis direction = Axis.vertical;
  final bool enableInfiniteLoad = true;

  Header getHeaderWidget() {
    return _Header();
  }

  @override
  Footer getFooterWidget({
    bool enableInfiniteLoad = true,
    bool safeArea = true,
    EdgeInsets padding,
  }) {
    return _Footer(
      enableInfiniteLoad: enableInfiniteLoad,
      safeArea: safeArea,
      padding: padding,
    );
  }

  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  Widget build(BuildContext context){
    return Container(
          child: EasyRefresh.custom(
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            taskIndependence: true,
            controller: _controller,
            scrollController: _scrollController,
            reverse: reverse,
            scrollDirection: direction,
            topBouncing: true,
            bottomBouncing: true,
            firstRefresh: false,
            // firstRefreshWidget: _getFirstRefreshWidget(),
            emptyWidget: widget.emptyWidget,
            header: getHeaderWidget(),
            footer: getFooterWidget(),
            onRefresh: ()async {
              await widget.onRefresh();
              if (mounted) {                
                _controller.resetLoadState();
                _controller.finishRefresh();
              }
            },
            onLoad: () async {
              await widget.onLoad();
              _controller.finishLoad();
            },
            slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return widget.scrollWidget(index) as Widget;
                },
                childCount: widget.count,
              ),
            ),
          ],
          ),
    );
  }
}