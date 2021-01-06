import 'package:app/config/ConfigData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends  StatefulWidget{

  // final Map params;
  HomePage();

  @override
  _HomePageState createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{
  // print(widget.params);
  @override
  Widget build(BuildContext context) {
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    ScreenUtil.init(context, width: ConfigData.width, height: ConfigData.width, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('组件列表'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            child: Text('搜索Search'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/delete');
            },
            child: Text('左滑删除'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/refresh');
            },
            child: Text('下拉刷新，上拉加载'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/timer');
            },
            child: Text('倒计时'),
          )
        ],
      )
    );
  }
  
}





