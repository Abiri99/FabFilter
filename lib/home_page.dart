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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
      vsync: this,
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
              top: MediaQuery.of(context).size.height - 360,
              right: 0,
              left: 0,
              bottom: 0,
              child: HomeBottomContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
