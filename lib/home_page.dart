import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/filter_icon.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'custom_drawer.dart';
import 'home_bottom_container.dart';
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
    print("home duration: ${widget.duration.inMilliseconds}");
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      drawer: Drawer(
        key: ValueKey(1),
        elevation: 24.0,
        child: CustomDrawer(),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        child: Positioned(
          top: mq.size.height - 380,
          right: 0,
          left: 0,
          bottom: 0,
          child: HomeBottomContainer(
            key: ValueKey(1),
            duration: widget.duration,
            animationCallback: animationCallback,
          ),
        ),
        builder: (context, child) => Stack(
          key: ValueKey(1),
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomAppBar(),
                  pinned: true,
                ),
                SliverFadeTransition(
                  opacity: _opacityAnimation,
                  sliver: SliverFillRemaining(
                    child: ListView(
                      cacheExtent: 500,
                      children: List.generate(10, (index) => ListItem(
                        key: ValueKey(index),
                        verticalPadding: _listViewAnimation.value * -4 + 24,
                        horizontalMargin: _listViewAnimation.value * 24,
                        // horizontalMargin: _listViewAnimation.value * 12 + 20,
                        // ver
                      ),),
                    ),
                  ),
                ),






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
            child,
          ],
        ),
      ),
    );
  }
}
