import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefreshText {
  static String pullToRefresh = '下拉刷新';

  static String releaseToRefresh = '释放刷新';

  static String refreshing = '刷新中 请稍后';

  static String refreshed = '刷新完成';

  static String refreshFailed = '刷新失败';

  static String noMore = '没有更多了';

  static String pushToLoad = '拉动加载';

  static String releaseToLoad = '释放加载';

  static String loading = '加载中 请稍候';

  static String loaded = '已经全部到底了';

  static String loadFailed = '加载失败';
}



class RefreshIcon {

  static const IconData list_update_fail = Icons.error_outline;

  static const IconData list_update_complete = Icons.done;

  static const IconData list_update_pull = Icons.keyboard_arrow_down;

}



class RefreshFont {
  static double get gap_dp8 => ScreenUtil().setWidth(16.0).toDouble();

  static double get font_sp12 => ScreenUtil().setSp(24.0).toDouble();

}