import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/filter_icon.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'action_icons.dart';
import 'action_icons_container.dart';
import 'custom_drawer.dart';
import 'fab_container.dart';
import 'filter_pageview_container.dart';
import 'filter_pageview_indicator_container.dart';
import 'list_item.dart';

class HomePage extends StatefulWidget {
  final Duration duration;

  HomePage({
    Key key,
    this.duration,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      drawer: Drawer(
        key: ValueKey(1),
        elevation: 24.0,
        child: CustomDrawer(),
      ),
      body: Stack(
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
                          : FadeTransition(
                              opacity: _opacityAnimation,
                              child: ScaleTransition(
                                alignment: Alignment.topCenter,
                                scale: _scaleAnimation,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: (1 - _scaleAnimation.value) * -40 + 8,
                                    // horizontal: _listViewAnimation.value * 18 + 12,
                                    // vertical: _listViewAnimation.value * -4 + 8,
                                  ),
                                  child: child,
                                ),
                              ),
                            );
                      ListItem(
                        key: ValueKey(index),
                        // opacity: _opacityAnimation.value,
                        // verticalPadding: _listViewAnimation.value * -4 + 24,
                        // horizontalMargin: _listViewAnimation.value * 18 + 18,
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
                      builder: (context, child) =>
                          FilterPageViewIndicatorContainer(
                        filterSheetAnimation: _filterSheetAnimation,
                        constraints: constraints,
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
          // AnimatedBuilder(
          //   animation: _controller,
          //   child: SliverPersistentHeader(
          //     delegate: CustomAppBar(),
          //     pinned: true,
          //   ),
          //   builder: (context, child) => CustomScrollView(
          //     slivers: [
          //       child,
          //       SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (context, position) {
          //             print("building item: $position");
          //             if (position == 0)
          //               return SizedBox(
          //                 height: 12,
          //               );
          //             return Opacity(
          //               key: ValueKey(position),
          //               opacity: 1,
          //               // opacity: 1 - _listViewAnimation.value * 0.4,
          //               child: Transform.scale(
          //                 scale: 1,
          //                 // scale: (1 - _listViewAnimation.value / 12),
          //                 alignment: Alignment.topCenter,
          //                 child: ListItem(
          //                   key: ValueKey(position),
          //                   horizontalMargin: 20,
          //                   verticalPadding: 24,
          //                   // horizontalMargin: _listViewAnimation.value * 12 + 20,
          //                   // verticalPadding: 24 - _listViewAnimation.value * 4,
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
