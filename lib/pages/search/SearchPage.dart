import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:app/components/MyTextField/MyTextField.dart';

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
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(
                Icons.search,
                color: Theme.of(context).disabledColor
              ),
            ),
            MyTextField(
              placeholder: '请输入搜索关键字',
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                Utils.showToast('关键词是：$text');
              }
            )
          ]
        ),
      )      
    );
  }



}