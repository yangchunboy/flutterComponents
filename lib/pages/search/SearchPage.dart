import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchState createState() {
    return _SearchState();
  }
  
}

class _SearchState extends State <SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索组件'),
      ),
      body: Column(
        children: <Widget>[
          Text('通用搜索'),
          searchComponent()
        ],
      ),
    );
  }


  Widget searchComponent() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Container(
        height: ScreenUtil().setHeight(33) as double,
        padding: EdgeInsets.only(left:16, right: 16),
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Theme.of(context).disabledColor
            ),
            Text(
              '搜索',
              style: TextStyle(
                color: Theme.of(context).disabledColor
              ),
            )
          ]
        ),
      )      
    );
  }



}