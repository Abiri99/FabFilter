import 'package:fab_filter/bottom_widgets/action_icons_background.dart';
import 'package:fab_filter/bottom_widgets/close_icon.dart';
import 'package:fab_filter/bottom_widgets/fab_background.dart';
import 'package:fab_filter/bottom_widgets/filter_icon_container.dart';
import 'package:fab_filter/bottom_widgets/filter_pageview.dart';
import 'package:fab_filter/bottom_widgets/page_view_indicators.dart';
import 'package:fab_filter/bottom_widgets2/aibs.dart';
import 'package:fab_filter/bottom_widgets2/fpv.dart';
import 'package:fab_filter/bottom_widgets2/pvi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_widgets2/ci.dart';
import 'bottom_widgets2/custom_listview.dart';
import 'bottom_widgets2/fic.dart';
import 'change_notifier/filters_change_notifier.dart';
import 'custom_appbar.dart';
import 'list_item.dart';

const String TAG = "HomePage";

class HomeBody extends StatefulWidget {
  final Duration duration;

  HomeBody({Key key, this.duration}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _filterController;

  Animation<double> _listViewAnimation;
  Animation<double> _listOpacityAnimation;
  Animation<double> _listScaleAnimation;

  Animation<double> _xAxisPositionAnimation;
  Animation<double> _yAxisPositionAnimation;

  Animation<double> _fabRevealAnimation;
  Animation<double> _fabIconFallAnimation;
  Animation<double> _actionIconTranslateAnimation;
  Animation<double> _filterSheetAnimation;

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
    // _controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed)
    //     _filterIconContainerKey.currentState.setControllerCompleted(true);
    //   else
    //     _filterIconContainerKey.currentState.setControllerCompleted(false);
    // });
    _filterController = AnimationController(
      value: 0.0,
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
    _listOpacityAnimation =
        Tween(begin: 1.0, end: 0.5).animate(_listViewAnimation);
    _listScaleAnimation =
        Tween(begin: 1.0, end: 0.9).animate(_listViewAnimation);

    _xAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeOut,
      ),
    );
    // _xAxisPositionAnimation.addListener(() {
    //   _fabBackgroundKey.currentState
    //       .setXAxisPositionAnimationValue(_xAxisPositionAnimation.value);
    //   _filterIconContainerKey.currentState
    //       .setXAxisPositionAnimationValue(_xAxisPositionAnimation.value);
    // });
    _yAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeIn,
      ),
    );
    // _yAxisPositionAnimation.addListener(() {
    //   _fabBackgroundKey.currentState
    //       .setYAxisPositionAnimationValue(_yAxisPositionAnimation.value);
    //   _filterIconContainerKey.currentState
    //       .setYAxisPositionAnimationValue(_yAxisPositionAnimation.value);
    // });
    _fabRevealAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    // _fabRevealAnimation.addListener(() {
    //   _fabBackgroundKey.currentState
    //       .setFabRevealAnimationValue(_fabRevealAnimation.value);
    //   _filterIconContainerKey.currentState
    //       .setFabRevealAnimationValue(_fabRevealAnimation.value);
    // });
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
    // _actionIconTranslateAnimation.addListener(() {
    //   _filterIconContainerKey.currentState
    //       .setActionIconsTranslateAnimationValue(
    //           _actionIconTranslateAnimation.value);
    //   _closeIconKey.currentState.setActionIconTranslateAnimationValue(
    //       _actionIconTranslateAnimation.value);
    // });
    _filterSheetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    // _filterSheetAnimation.addListener(() {
    //   _pageViewIndicatorsKey.currentState
    //       .setFilterSheetAnimation(_filterSheetAnimation.value);
    //   _filterPageViewKey.currentState
    //       .setFilterSheetAnimationValue(_filterSheetAnimation.value);
    //   _actionIconsBackgroundKey.currentState
    //       .setFilterSheetAnimationValue(_filterSheetAnimation.value);
    // });
    _fadeOutAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.0,
        0.1,
        curve: Curves.easeOut,
      ),
    );
    // _fadeOutAnimation.addListener(() {
    //   _pageViewIndicatorsKey.currentState
    //       .setFadeOutAnimationValue(_fadeOutAnimation.value);
    //   _fabBackgroundKey.currentState
    //       .setFadeOutAnimation(_fadeOutAnimation.value);
    //   _filterPageViewKey.currentState
    //       .setFadeOutAnimationValue(_fadeOutAnimation.value);
    //   _filterIconContainerKey.currentState
    //       .setFadeOutAnimationValue(_fadeOutAnimation.value);
    //   _closeIconKey.currentState
    //       .setFadeOutAnimationValue(_fadeOutAnimation.value);
    //   _actionIconsBackgroundKey.currentState
    //       .setFadeOutAnimationValue(_fadeOutAnimation.value);
    // });
    _fabWrapperSizeAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.0,
        0.15,
        curve: Curves.elasticIn,
      ),
    );
    // _fabWrapperSizeAnimation.addListener(() {
    //   _fabBackgroundKey.currentState.fabWrapperSizeAnimationValue = _fabWrapperSizeAnimation.value;
    // });
    _fabRotateAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Interval(
        0.25,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    // _fabRotateAnimation.addListener(() {
    //   _closeIconKey.currentState
    //       .setFabRotationAnimationValue(_fabRotateAnimation.value);
    // });
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
    var fpvHeight = 350.0;
    // var bottomActionButtonContainerHeight = 80;
    var topIndicatorListViewHeight = 60.0;
    var fabWidth = 80.0;
    var fabMargin = 36.0;
    var fabIconWidth = 32.0;
    // WidgetsBinding.instance.addPostFrameCallback((_) => registerPageListener());
    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: CustomAppBar(),
              pinned: true,
            ),
            CustomListView(
              scaleAnimation: _listScaleAnimation,
              opacityAnimation: _listOpacityAnimation,
            ),
          ],
        ),
        Container(
          // height: 500,
          alignment: Alignment.bottomCenter,
          // color: Colors.green.withOpacity(0.5),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PVI(
                  // key: UniqueKey(),
                  filterSheetAnimation: _filterSheetAnimation,
                  fadeOutAnimation: _fadeOutAnimation,
                  topIndicatorListHeight: topIndicatorListViewHeight,
                  scrollController: _scrollController,
                  animateToPage: animateToPage,
                  fpvHeight: fpvHeight,
                ),
                FabBackground(
                  constraints: constraints,
                  topIndicatorListViewHeight: topIndicatorListViewHeight,
                  fabWidth: fabWidth,
                  fabMargin: fabMargin,
                  tapCallback: () {
                    _controller.forward();
                  },
                  fabRevealAnimation: _fabRevealAnimation,
                  fadeOutAnimation: _fadeOutAnimation,
                  xAxisPositionAnimation: _xAxisPositionAnimation,
                  yAxisPositionAnimation: _yAxisPositionAnimation,
                  fabWrapperSizeAnimation: _fabWrapperSizeAnimation,
                  fpvHeight: fpvHeight,
                ),
                FPV(
                  pageController: _pageController,
                  filterSheetAnimation: _filterSheetAnimation,
                  fadeOutAnimation: _fadeOutAnimation,
                  topIndicatorListViewHeight: topIndicatorListViewHeight,
                  fpvHeight: fpvHeight,
                ),
                AIBS(
                  fabWidth: fabWidth,
                  constraints: constraints,
                  xAxisPositionAnimation: _xAxisPositionAnimation,
                  yAxisPositionAnimation: _yAxisPositionAnimation,
                  fadeOutAnimation: _fadeOutAnimation,
                  fabRotateAnimation: _fabRotateAnimation,
                  filterSheetAnimation: _filterSheetAnimation,
                ),
                FIC(
                  fabWidth: fabWidth,
                  constraints: constraints,
                  filterControllerCallback: () {
                    _filterController.forward();
                  },
                  fpvHeight: fpvHeight,
                  xAxisPositionAnimation: _xAxisPositionAnimation,
                  yAxisPositionAnimation: _yAxisPositionAnimation,
                  fadeOutAnimation: _fadeOutAnimation,
                  fabRevealAnimation: _fabRevealAnimation,
                  actionIconsTranslateAnimation: _actionIconTranslateAnimation,
                ),
                CI(
                  tapCallback: () {
                    _controller.reverse();
                  },
                  fabWidth: fabWidth,
                  fadeOutAnimation: _fadeOutAnimation,
                  fabRotationAnimation: _fabRotateAnimation,
                  actionIconTranslateAnimation: _actionIconTranslateAnimation,
                ),
              ],
            ),
          ),
        ),

        // Positioned(
        //   top: mq.size.height - bottomSheetHeight - topIndicatorListViewHeight,
        //   right: 0,
        //   left: 0,
        //   bottom: 0,
        //   child: LayoutBuilder(
        //     builder: (context, constraints) {
        //       return Container(
        //         child: Stack(
        //           children: [
        //             // PageView Indicators
        //             PageViewIndicators(
        //               key: _pageViewIndicatorsKey,
        //               constraints: constraints,
        //               animateToPage: animateToPage,
        //               scrollController: _scrollController,
        //             ),
        //
        //             Positioned(
        //               top: topIndicatorListViewHeight,
        //               right: 0,
        //               left: 0,
        //               bottom: 0,
        //               child: Container(
        //                 child: Stack(
        //                   fit: StackFit.expand,
        //                   children: [
        //                     // Fab background
        //                     FabBackground(
        //                       key: _fabBackgroundKey,
        //                       tapCallback: () {
        //                         if (_controller.status ==
        //                             AnimationStatus.completed)
        //                           _controller.reverse();
        //                         else
        //                           _controller.forward();
        //                       },
        //                       constraints: constraints,
        //                       topIndicatorListViewHeight:
        //                           topIndicatorListViewHeight,
        //                       fabWidth: fabWidth,
        //                       fabMargin: fabMargin,
        //                     ),
        //
        //                     // Filter PageView
        //                     FilterPageView(
        //                       key: _filterPageViewKey,
        //                       pageController: _pageController,
        //                     ),
        //
        //                     // Action Icons Background Container
        //                     ActionIconsBackground(
        //                       key: _actionIconsBackgroundKey,
        //                       fabWidth: fabWidth,
        //                       constraints: constraints,
        //                     ),
        //
        //                     // Filter Icon
        //                     FilterIconContainer(
        //                       key: _filterIconContainerKey,
        //                       fabWidth: fabWidth,
        //                       constraints: constraints,
        //                       filterControllerCallback: () {
        //                         _filterController.forward();
        //                       },
        //                     ),
        //
        //                     // Close Icon
        //                     CloseIcon(
        //                       key: _closeIconKey,
        //                       tapCallback: () {
        //                         _controller.reverse();
        //                       },
        //                       fabWidth: fabWidth,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
