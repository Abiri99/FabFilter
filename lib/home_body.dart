import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'action_icons.dart';
import 'action_icons_container.dart';
import 'change_notifier/filters_change_notifier.dart';
import 'custom_appbar.dart';
import 'fab_container.dart';
import 'filter_pageview_container.dart';
import 'filter_pageview_indicator.dart';
import 'list_item.dart';

const String TAG = "HomePage";

class HomeBody extends StatefulWidget {

  final Duration duration;

  HomeBody({Key key, this.duration}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    print("$TAG didChangeDependencies");
    _controller = AnimationController(
      duration: widget.duration,
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
    _yAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        0.2,
        curve: Curves.easeIn,
      ),
    );
    _fabRevealAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.2,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
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
    _filterSheetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animationCallback(bool value) {
    if (value) {
      if (_controller.status != AnimationStatus.forward) _controller.forward();
    } else {
      if (_controller.status != AnimationStatus.reverse) _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomAppBar(),
              pinned: true,
            ),
            AnimatedBuilder(
              animation: _listViewAnimation,
              child: ListItem(),
              // child: Container(
              //   height: 100,
              //   color: Colors.red,
              // ),
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
                                      (1 - _scaleAnimation.value) * -40 + 8,
                                  // horizontal: _listViewAnimation.value * 18 + 12,
                                  // vertical: _listViewAnimation.value * -4 + 8,
                                ),
                                child: child,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            // SliverFillRemaining(
            //   child: FadeTransition(
            //     opacity: _opacityAnimation,
            //     child: ScaleTransition(
            //       scale: _scaleAnimation,
            //       alignment: Alignment.topCenter,
            //       child: ListView.builder(
            //         semanticChildCount: 20,
            //         addAutomaticKeepAlives: false,
            //         // cacheExtent: 5000,
            //         itemCount: 30,
            //         itemBuilder: (context, index) => ListItem(
            //           key: ValueKey(index),
            //           // verticalPadding: _scaleAnimation.value * -4 + 24,
            //           // horizontalMargin: _scaleAnimation.value * 12,
            //           // horizontalMargin: _listViewAnimation.value * 12 + 20,
            //           // ver
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // ),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, position) {
            //       if (position == 0)
            //         return SizedBox(
            //           key: ValueKey(0),
            //           height: 12,
            //         );
            //       return FadeTransition(
            //         opacity: _opacityAnimation,
            //         child: Container(
            //           // height: 86,
            //           color: Colors.white,
            //           margin: EdgeInsets.symmetric(horizontal: _listViewAnimation.value * 12 + 20, vertical: 8,),
            //           padding: EdgeInsets.symmetric(vertical: 24 - _listViewAnimation.value * 4),
            //           child: Text(""),
            //         ),
            //       );
            //       // return ListItem(
            //       //   key: ValueKey(position),
            //       //   horizontalMargin: _listViewAnimation.value * 12 + 20,
            //       //   verticalPadding: 24 - _listViewAnimation.value * 4,
            //       // );
            //     },
            //   ),
            // ),
          ],
        ),
        Positioned(
          top: mq.size.height - 380,
          right: 0,
          left: 0,
          bottom: 0,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              // color: Colors.red,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _filterSheetAnimation,
                    child: FilterPageViewIndicator(
                      currentPage: 2,
                    ),
                    builder: (context, child) => Positioned(
                      top: (1 - _filterSheetAnimation.value) * 64 + 0,
                      left: 0,
                      right: 0,
                      bottom: constraints.maxHeight -
                          64 -
                          ((1 - _filterSheetAnimation.value) * 86),
                      child: IgnorePointer(
                        ignoring: false,
                        child: Opacity(
                          opacity: _filterSheetAnimation.value == 0 ? 0.0 : 1.0,
                          child: ChangeNotifierProvider(
                            create: (context) => FiltersChangeNotifier(),
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(0xff164A6D),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 64,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      // color: Colors.blue,
                      // margin: const EdgeInsets.only(top: 64),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          /// Fab background
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) => FabContainer(
                              controller: _controller,
                              fabRevealAnimation: _fabRevealAnimation,
                              xAxisPositionAnimation: _xAxisPositionAnimation,
                              yAxisPositionAnimation: _yAxisPositionAnimation,
                              constraints: constraints,
                            ),
                          ),

                          /// PageView
                          AnimatedBuilder(
                            animation: _filterSheetAnimation,
                            builder: (context, child) => IgnorePointer(
                              ignoring: _filterSheetAnimation.value == 1.0
                                  ? false
                                  : true,
                              child: FilterPageViewContainer(
                                  _filterSheetAnimation),
                            ),
                          ),

                          /// Action Icons Background Container
                          AnimatedBuilder(
                            animation: _filterSheetAnimation,
                            builder: (context, child) =>
                                ActionIconsContainer(_filterSheetAnimation),
                          ),

                          /// Action Icons
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) => ActionIcons(
                              fabIconFallAnimation: _fabIconFallAnimation,
                              xAxisPositionAnimation: _xAxisPositionAnimation,
                              yAxisPositionAnimation: _yAxisPositionAnimation,
                              actionIconTranslateAnimation:
                                  _actionIconTranslateAnimation,
                              constraints: constraints,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _actionIconTranslateAnimation,
                            builder: (context, child) => Positioned(
                              bottom: 16,
                              left: 16 +
                                  (_actionIconTranslateAnimation.value *
                                      constraints.maxWidth /
                                      4) -
                                  40,
                              child: GestureDetector(
                                onTap: () {
                                  _controller.reverse();
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  // margin: const EdgeInsets.all(24),
                                  child: Opacity(
                                    opacity:
                                        _actionIconTranslateAnimation.value,
                                    child: Icon(
                                      Icons.close,
                                      size: 28,
                                      color: Color(0xff8EB8C6),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
