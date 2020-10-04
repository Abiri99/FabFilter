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

  AnimationController _fabPositionController;

  Animation<double> _listViewAnimation;

  @override
  void initState() {
    _fabPositionController = AnimationController(
      duration: Duration(milliseconds: 2000),
      reverseDuration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _listViewAnimation = CurvedAnimation(
      parent: _fabPositionController,
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
    _fabPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: AnimatedBuilder(
        animation: _fabPositionController,
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
                      return Opacity(
                        opacity: 1 - _listViewAnimation.value * 0.4,
                        child: ListItem(
                          key: ValueKey(position),
                          horizontalMargin: _listViewAnimation.value * 12 + 20,
                          verticalPadding: 20 - _listViewAnimation.value * 4,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: mq.size.height - 380,
              right: 0,
              left: 0,
              bottom: 0,
              child: HomeBottomContainer(
                controller: _fabPositionController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
