import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/filter_icon.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'home_bottom_container.dart';
import 'list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _listViewAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animationCallback(bool value) {
    if (value) {
      print("true");
      _controller.forward();
    } else {
      print("false");
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: AnimatedBuilder(
        animation: _controller,
        child: Positioned(
          top: mq.size.height - 380,
          right: 0,
          left: 0,
          bottom: 0,
          child: HomeBottomContainer(
            animationCallback: animationCallback,
          ),
        ),
        builder: (context, child) => Stack(
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomAppBar(),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, position) {
                      print("building item $position");
                      if (position == 0)
                        return SizedBox(
                          height: 12,
                        );
                      return Opacity(
                        key: ValueKey(position),
                        // opacity: _listViewAnimation,
                        opacity: 1 - _listViewAnimation.value * 0.4,
                        child: Transform.scale(
                          scale: 1 - _listViewAnimation.value * 0.1,
                          // child: Container(
                          //   width: 100,
                          //   height: 100,
                          //   color: Colors.red,
                          //   margin: const EdgeInsets.all(8),
                          // ),
                          // ),
                          child: ListItem(
                            key: ValueKey(position),
                            horizontalMargin: 20,
                            verticalPadding: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
