part of scroll_list;

class _Header extends Header {
  _Header({
    double extent = 60.0,
    double triggerDistance = 70.0,
    Duration completeDuration = const Duration(seconds: 1),
    this.key,
    Color bgColor,
  })  : bgColor = bgColor ?? Colors.transparent,
        super(
          extent: extent,
          triggerDistance: triggerDistance,
          completeDuration: completeDuration,
          enableInfiniteRefresh: false,
          enableHapticFeedback: false,
        );

  /// Key
  final Key key;

  /// 背景颜色
  final Color bgColor;

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    return _HeaderWidget(
      key: key,
      ctHeader: this,
      refreshState: refreshState,
      pulledExtent: pulledExtent,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      success: success,
    );
  }
}

class _HeaderWidget extends StatefulWidget {
  const _HeaderWidget(
      {Key key,
      this.ctHeader,
      this.refreshState,
      this.success,
      this.pulledExtent,
      this.refreshTriggerPullDistance,
      this.refreshIndicatorExtent})
      : super(key: key);

  final _Header ctHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final bool success;

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<_HeaderWidget>
    with TickerProviderStateMixin<_HeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      _refreshFinish = finish;
    }
  }

  // 动画
  AnimationController _readyController;
  Animation<double> _readyAnimation;
  AnimationController _restoreController;
  Animation<double> _restoreAnimation;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  String get _pullToRefresh => RefreshText.pullToRefresh;

  String get _refreshReadyText => RefreshText.releaseToRefresh;

  String get _refreshingText => RefreshText.refreshing;

  String get _refreshedText => RefreshText.refreshed;

  // 刷新结束图标
  IconData get _finishedIcon {
    if (!widget.success) {
      return RefreshIcon.list_update_fail;
    }
    return RefreshIcon.list_update_complete;
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success) {
      return RefreshText.refreshFailed;
    }
    return _refreshedText;
  }

  Color get _textColor => Color(0xFFBFBFBF);

  double get _iconSize => RefreshFont.font_sp12;

  // 显示文字
  String get _showText {
    switch (widget.refreshState) {
      case RefreshMode.refresh:
        return _refreshingText;
      case RefreshMode.armed:
        return _refreshingText;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return _refreshReadyText;
        } else {
          return _pullToRefresh;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    // 准备动画
    _readyController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = Tween(begin: 0.5, end: 1.0).animate(_readyController)
      ..addListener(() {
        setState(() {
          if (_readyAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _readyAnimation.value;
          }
        });
      });
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    // 恢复动画
    _restoreController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation = Tween(begin: 1.0, end: 0.5).animate(_restoreController)
      ..addListener(() {
        setState(() {
          if (_restoreAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _restoreAnimation.value;
          }
        });
      });
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否到达触发刷新距离
    overTriggerDistance = widget.refreshState != RefreshMode.inactive &&
        widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (widget.refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }

    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: widget.refreshIndicatorExtent > widget.pulledExtent
                ? widget.refreshIndicatorExtent
                : widget.pulledExtent,
            color: widget.ctHeader.bgColor,
            child: SizedBox(
              height: widget.refreshIndicatorExtent,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建显示内容
  List<Widget> _buildContent() {
    return <Widget>[
      Container(
        padding: EdgeInsets.only(right: RefreshFont.gap_dp8),
        alignment: Alignment.centerRight,
        child: widget.refreshState == RefreshMode.refresh ||
                widget.refreshState == RefreshMode.armed
            ? CupertinoActivityIndicator(
                radius: _iconSize / 2,
              )
            : widget.refreshState == RefreshMode.refreshed ||
                    widget.refreshState == RefreshMode.done
                ? Icon(
                    _finishedIcon,
                    color: _textColor,
                    size: _iconSize,
                  )
                : Transform.rotate(
                    child: Icon(
                      RefreshIcon.list_update_pull,
                      color: _textColor,
                      size: _iconSize,
                    ),
                    angle: 2 * pi * _iconRotationValue,
                  ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _showText,
              style: TextStyle(
                  fontSize: RefreshFont.font_sp12, color: _textColor, height: 1.0),
            ),
          ],
        ),
      ),
    ];
  }
}
