import 'package:fab_filter/custom_appbar.dart';
import 'package:fab_filter/filter_icon.dart';
import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _xAxisPositionAnimation;
  Animation _yAxisPositionAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
    );
    _xAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    );
    _yAxisPositionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: AnimatedBuilder(
        animation: _controller,
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
                      return Transform.scale(
                        scale: 1.0,
                        // scale: 1.0 - _controller.value * 0.1,
                        child: Opacity(
                          opacity: 1 - _controller.value * 0.4,
                          child: ListItem(
                            horizontalMargin: _controller.value * 12 + 18,
                            verticalPadding: 20 - _controller.value * 4,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: (_yAxisPositionAnimation.value *
                  (MediaQuery.of(context).size.height / 3 - 56) as double),
              right: (_xAxisPositionAnimation.value *
                  (MediaQuery.of(context).size.width / 2 - 56) as double),
              child: GestureDetector(
                onTap: () {
                  if (_controller.status == AnimationStatus.completed) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: Container(
                  height: 64,
                  width: 64,
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: FilterIcon(),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 15),
                        blurRadius: 15,
                        spreadRadius: -8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
