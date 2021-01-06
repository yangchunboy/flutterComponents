import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app/components/Fresh/Refresh.dart';

class RefreshPage extends StatefulWidget{
    _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<RefreshPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉刷新，上拉加载')
      ),
      body: Column(
        children: <Widget>[
          Text('下拉刷新，上拉加载'),
          Expanded(
            child: Refresh(
              scrollWidget: (int index) {
                return Text('我是第$index个滑动的组件');
              },
              count: 20,
              onRefresh: () {
                Utils.showToast('触发下拉刷新');
              },
              onLoad: () {
                Utils.showToast('触发上拉加载');
              },
              emptyWidget: Text('我是空页面')
            )
          )
        ]
      ),
    );
  }
}