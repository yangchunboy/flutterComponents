part of scroll_list;

class _Footer extends Footer {
  _Footer({
    double extent = 60.0,
    double triggerDistance = 70.0,
    Duration completeDuration = const Duration(seconds: 1),
    bool enableInfiniteLoad = true,
    this.key,
    Color bgColor,
    bool safeArea = true,
    EdgeInsets padding,
  })  : bgColor = bgColor ?? Colors.transparent,
        super(
          extent: extent,
          triggerDistance: triggerDistance,
          completeDuration: completeDuration,
          enableInfiniteLoad: enableInfiniteLoad,
          safeArea: safeArea,
          padding: padding,
        );

  /// Key
  final Key key;

  /// 背景颜色
  final Color bgColor;

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    return _FooterWidget(
      key: key,
      ctFooter: this,
      loadState: loadState,
      pulledExtent: pulledExtent,
      loadTriggerPullDistance: loadTriggerPullDistance,
      loadIndicatorExtent: loadIndicatorExtent,
      axisDirection: axisDirection,
      enableInfiniteLoad: enableInfiniteLoad,
      success: success,
      noMore: noMore,
    );
  }
}

class _FooterWidget extends StatefulWidget {
  const _FooterWidget(
      {Key key,
      this.ctFooter,
      this.loadState,
      this.pulledExtent,
      this.loadTriggerPullDistance,
      this.loadIndicatorExtent,
      this.axisDirection,
      this.enableInfiniteLoad,
      this.success,
      this.noMore})
      : super(key: key);

  final _Footer ctFooter;
  final LoadMode loadState;
  final double pulledExtent;
  final double loadTriggerPullDistance;
  final double loadIndicatorExtent;
  final AxisDirection axisDirection;
  final bool enableInfiniteLoad;
  final bool success;
  final bool noMore;

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<_FooterWidget>
    with TickerProviderStateMixin<_FooterWidget> {
  // 是否到达触发加载距离
  bool _overTriggerDistance = false;
  bool get overTriggerDistance => _overTriggerDistance;
  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
    }
    _overTriggerDistance = over;
  }

  // 动画
  AnimationController _readyController;
  Animation<double> _readyAnimation;
  AnimationController _restoreController;
  Animation<double> _restoreAnimation;

  /// 没有更多文字
  String get _noMoreText => RefreshText.noMore;

  String get _pushToLoadText => RefreshText.pushToLoad;

  String get _loadReadyText => RefreshText.releaseToLoad;

  String get _loadingText => RefreshText.loading;

  String get _loadedText => RefreshText.loaded;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 显示文字
  String get _showText {
    if (widget.noMore) {
      return _noMoreText;
    }
    if (widget.enableInfiniteLoad) {
      if (widget.loadState == LoadMode.loaded ||
          widget.loadState == LoadMode.inactive ||
          widget.loadState == LoadMode.drag) {
        return _finishedText;
      } else {
        return _loadingText;
      }
    }
    switch (widget.loadState) {
      case LoadMode.load:
        return _loadingText;
      case LoadMode.armed:
        return _loadingText;
      case LoadMode.loaded:
        return _finishedText;
      case LoadMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return _loadReadyText;
        } else {
          return _pushToLoadText;
        }
    }
  }

  // 刷新结束图标
  IconData get _finishedIcon {
    if (!widget.success) {
      return RefreshIcon.list_update_fail;
    }
    return RefreshIcon.list_update_complete;
  }

  // 加载结束文字
  String get _finishedText {
    if (!widget.success) {
      return RefreshText.loadFailed;
    }
    if (widget.noMore) {
      return _noMoreText;
    }
    return _loadedText;
  }

  Color get _textColor => Color(0xFFBFBFBF);

  double get _iconSize => RefreshFont.font_sp12;

  @override
  void initState() {
    super.initState();
    // 初始化动画
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
    final bool isVertical = widget.axisDirection == AxisDirection.down
        || widget.axisDirection == AxisDirection.up;
    final bool isReverse = widget.axisDirection == AxisDirection.up
        || widget.axisDirection == AxisDirection.left;

    // 是否到达触发加载距离
    overTriggerDistance = widget.loadState != LoadMode.inactive &&
        widget.pulledExtent >= widget.loadTriggerPullDistance;

    return Stack(
      children: [
        Positioned(
          top: isVertical ? !isReverse ? 0.0 : null : 0.0,
          bottom: isVertical ? isReverse ? 0.0 : null : 0.0,
          left: !isVertical ? !isReverse ? 0.0 : null : 0.0,
          right: !isVertical ? isReverse ? 0.0 : null : 0.0,
          child: Container(
            alignment: isVertical ? !isReverse ? Alignment.topCenter
                : Alignment.bottomCenter : !isReverse
                ? Alignment.centerLeft : Alignment.centerRight,
            width: double.infinity,
            height: widget.loadIndicatorExtent > widget.pulledExtent
                ? widget.loadIndicatorExtent
                : widget.pulledExtent,
            color: widget.ctFooter.bgColor,
            child: SizedBox(
              height: widget.loadIndicatorExtent,
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
        child: (widget.loadState == LoadMode.load ||
                    widget.loadState == LoadMode.armed) &&
                !widget.noMore
            ? CupertinoActivityIndicator(
                radius: _iconSize / 2,
              )
            : widget.loadState == LoadMode.loaded ||
                    widget.loadState == LoadMode.done ||
                    (widget.enableInfiniteLoad &&
                        widget.loadState != LoadMode.loaded) ||
                    widget.noMore
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
                fontSize: RefreshFont.font_sp12,
                color: _textColor,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
