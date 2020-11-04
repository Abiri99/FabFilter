import 'package:fab_filter/bottom_widgets/action_icons_background.dart';
import 'package:fab_filter/bottom_widgets/close_icon.dart';
import 'package:fab_filter/bottom_widgets/fab_background.dart';
import 'package:fab_filter/bottom_widgets/filter_icon_container.dart';
import 'package:fab_filter/bottom_widgets/filter_pageview.dart';
import 'package:fab_filter/bottom_widgets/page_view_indicators.dart';
import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/util/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier/filter2_change_notifier.dart';
import 'change_notifier/filters_change_notifier.dart';
import 'custom_appbar.dart';
import 'filter_icon.dart';
import 'filter_pageview_indicator_list.dart';
import 'filter_view.dart';
import 'filter_view2.dart';
import 'list_item.dart';

const String TAG = "HomePage";

class HomeBody extends StatefulWidget {
  final Duration duration;

  HomeBody({Key key, this.duration}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  GlobalKey<PageViewIndicatorsState> _pageViewIndicatorsKey =
      GlobalKey<PageViewIndicatorsState>();
  GlobalKey<FabBackgroundState> _fabBackgroundKey =
      GlobalKey<FabBackgroundState>();
  GlobalKey<FilterPageViewState> _filterPageViewKey =
      GlobalKey<FilterPageViewState>();
  GlobalKey<ActionIconsBackgroundState> _actionIconsBackgroundKey =
      GlobalKey<ActionIconsBackgroundState>();
  GlobalKey<FilterIconContainerState> _filterIconContainerKey =
      GlobalKey<FilterIconContainerState>();
  GlobalKey<CloseIconState> _closeIconKey = GlobalKey<CloseIconState>();

  AnimationController _controller;

  Animation<double> _listViewAnimation;
  Animation<double> _opacityAnimation;
  Animation<double> _scaleAnimation;

  Animation<double> _xAxisPositionAnimation;
  Animation<double> _yAxisPositionAnimation;

  Animation<double> _fabRevealAnimation;
  Animation<double> _fabIconFallAnimation;
  Animation<double> _actionIconTranslateAnimation;
  Animation<double> _filterSheetAnimation;

  AnimationController _filterController;
  Animation<double> _fadeOutAnimation;
  Animation<double> _fabWrapperSizeAnimation;
  Animation<double> _fabRotateAnimation;
  Animation<double> _xAxisReplaceAnimation;
  Animation<double> _yAxisReplaceAnimation;

  ScrollController _scrollController;
  PageController _pageController;

  double _currentPage;

  _pageChangeCallback(double page, MediaQueryData mq) {
    _pageController.animateToPage(
      page.floor(),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  Future<void> registerPageListener(BuildContext context) async {
    _pageController.addListener(() {
      _scrollController.jumpTo((mounted ? _pageController.page : 0) * 116);
      Provider.of<FiltersChangeNotifier>(context, listen: false)
          .setCurrentPage(_pageController.page);
      // setState(() {
      //   _currentPage = _pageController.page;
      // });
    });
  }

  @override
  void didChangeDependencies() {
    registerPageListener(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _pageController = PageController(initialPage: 0);
    _currentPage = 0;
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.duration,
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _filterIconContainerKey.currentState.setControllerCompleted(true);
      else
        _filterIconContainerKey.currentState.setControllerCompleted(false);
    });
    _filterController = AnimationController(
      duration: Duration(milliseconds: widget.duration.inMilliseconds * 3),
      reverseDuration: widget.duration,
      vsync: this,
    );
    _listViewAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    _opacityAnimation = Tween(begin: 1.0, end: 0.5).animate(_listViewAnimation);
    _scaleAnimation = Tween(begin: 1.0, end: 0.9).animate(_listViewAnimation);

    _xAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    _xAxisPositionAnimation.addListener(() {
      _fabBackgroundKey.currentState
          .setXAxisPositionAnimationValue(_xAxisPositionAnimation.value);
      _filterIconContainerKey.currentState
          .setXAxisPositionAnimationValue(_xAxisPositionAnimation.value);
    });
    _yAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeIn,
      ),
    );
    _yAxisPositionAnimation.addListener(() {
      _fabBackgroundKey.currentState
          .setYAxisPositionAnimationValue(_yAxisPositionAnimation.value);
      _filterIconContainerKey.currentState
          .setYAxisPositionAnimationValue(_yAxisPositionAnimation.value);
    });
    _fabRevealAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _fabRevealAnimation.addListener(() {
      _fabBackgroundKey.currentState
          .setFabRevealAnimationValue(_fabRevealAnimation.value);
      _filterIconContainerKey.currentState
          .setFabRevealAnimationValue(_fabRevealAnimation.value);
    });
    _fabIconFallAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _actionIconTranslateAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.easeOut,
      ),
    );
    _actionIconTranslateAnimation.addListener(() {
      _filterIconContainerKey.currentState
          .setActionIconsTranslateAnimationValue(
              _actionIconTranslateAnimation.value);
      _closeIconKey.currentState.setActionIconTranslateAnimationValue(
          _actionIconTranslateAnimation.value);
    });
    _filterSheetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    _filterSheetAnimation.addListener(() {
      _pageViewIndicatorsKey.currentState
          .setFilterSheetAnimation(_filterSheetAnimation.value);
      _filterPageViewKey.currentState
          .setFilterSheetAnimationValue(_filterSheetAnimation.value);
      _actionIconsBackgroundKey.currentState
          .setFilterSheetAnimationValue(_filterSheetAnimation.value);
    });
    _fadeOutAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.0,
        0.1,
        curve: Curves.easeOut,
      ),
    );
    _fadeOutAnimation.addListener(() {
      _pageViewIndicatorsKey.currentState
          .setFadeOutAnimationValue(_fadeOutAnimation.value);
      _fabBackgroundKey.currentState
          .setFadeOutAnimation(_fadeOutAnimation.value);
      _filterPageViewKey.currentState
          .setFadeOutAnimationValue(_fadeOutAnimation.value);
      _filterIconContainerKey.currentState
          .setFadeOutAnimationValue(_fadeOutAnimation.value);
      _closeIconKey.currentState
          .setFadeOutAnimationValue(_fadeOutAnimation.value);
      _actionIconsBackgroundKey.currentState
          .setFadeOutAnimationValue(_fadeOutAnimation.value);
    });
    _fabWrapperSizeAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.0,
        0.15,
        curve: Curves.elasticIn,
      ),
    );
    _fabWrapperSizeAnimation.addListener(() {
      _fabBackgroundKey.currentState.fabWrapperSizeAnimationValue = _fabWrapperSizeAnimation.value;
    });
    _fabRotateAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.25,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _fabRotateAnimation.addListener(() {
      _closeIconKey.currentState
          .setFabRotationAnimationValue(_fabRotateAnimation.value);
    });
    _xAxisReplaceAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.5,
        0.65,
        curve: Curves.easeIn,
      ),
    );
    _yAxisReplaceAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.5,
        0.65,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _filterController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  animationCallback(bool value) {
    if (value) {
      if (_controller.status != AnimationStatus.forward) _controller.forward();
    } else {
      if (_controller.status != AnimationStatus.reverse) _controller.reverse();
    }
  }

  animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var bottomSheetHeight = 350;
    var topIndicatorListViewHeight = 60.0;
    var fabWidth = 72.0;
    var fabMargin = 36.0;
    var fabIconWidth = 32.0;
    // WidgetsBinding.instance.addPostFrameCallback((_) => registerPageListener());
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: CustomAppBar(),
              pinned: true,
            ),
            AnimatedBuilder(
              animation: _listViewAnimation,
              child: ListItem(),
              builder: (context, child) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return index == 0
                        ? SizedBox(
                            height: 12,
                          )
                        :
                        // : child
                        FadeTransition(
                            opacity: _opacityAnimation,
                            child: ScaleTransition(
                              alignment: Alignment.topCenter,
                              scale: _scaleAnimation,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical:
                                      (1 - _scaleAnimation.value) * -40 + 10,
                                ),
                                child: child,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),

        // Fab Background 1
        // AnimatedBuilder(
        //   animation: _filterController,
        //   builder: (context, child) {
        //     print("_fabWrapperStatus: ${_fabWrapperSizeAnimation.status}");
        //     return Positioned(
        //       // left: 0,
        //       // right: 0,
        //       // bottom: 0,
        //       right: 100 * (-1 + _xAxisReplaceAnimation.value),
        //       left: _fabWrapperSizeAnimation.isCompleted ? 0 : -100,
        //       bottom: 100 * (-1 + _yAxisReplaceAnimation.value),
        //       top: mq.size.height - bottomSheetHeight - 100,
        //       child: IgnorePointer(
        //         child: Align(
        //           alignment: Alignment(
        //             0 + _xAxisReplaceAnimation.value,
        //             0 + _yAxisReplaceAnimation.value,
        //           ),
        //           child: FadeTransition(
        //             opacity: _fadeOutAnimation,
        //             child: Container(
        //               height: 86 + (1 - _fabWrapperSizeAnimation.value) * 500,
        //               width: 86 + (1 - _fabWrapperSizeAnimation.value) * 500,
        //               margin: const EdgeInsets.all(36.0),
        //               decoration: BoxDecoration(
        //                 color: Theme.of(context).primaryColorDark,
        //                 borderRadius: BorderRadius.all(
        //                   Radius.circular(500),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),

        // Bottom Sheet
        Positioned(
          top: mq.size.height - bottomSheetHeight - topIndicatorListViewHeight,
          right: 0,
          left: 0,
          bottom: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                child: Stack(
                  children: [
                    // PageView Indicators
                    PageViewIndicators(
                      key: _pageViewIndicatorsKey,
                      constraints: constraints,
                      animateToPage: animateToPage,
                      scrollController: _scrollController,
                    ),

                    Positioned(
                      top: topIndicatorListViewHeight,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Fab background
                            FabBackground(
                              key: _fabBackgroundKey,
                              tapCallback: () {
                                if (_controller.status ==
                                    AnimationStatus.completed)
                                  _controller.reverse();
                                else
                                  _controller.forward();
                              },
                              constraints: constraints,
                              topIndicatorListViewHeight:
                                  topIndicatorListViewHeight,
                              fabWidth: fabWidth,
                              fabMargin: fabMargin,
                            ),

                            // Filter PageView
                            FilterPageView(
                              key: _filterPageViewKey,
                              pageController: _pageController,
                            ),

                            // Action Icons Background Container
                            ActionIconsBackground(
                              key: _actionIconsBackgroundKey,
                              fabWidth: fabWidth,
                              constraints: constraints,
                            ),

                            // Filter Icon
                            FilterIconContainer(
                              key: _filterIconContainerKey,
                              fabWidth: fabWidth,
                              constraints: constraints,
                              filterControllerCallback: () {
                                _filterController.forward();
                              },
                            ),

                            // Close Icon
                            CloseIcon(
                              key: _closeIconKey,
                              tapCallback: () {
                                _controller.reverse();
                              },
                              fabWidth: fabWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
