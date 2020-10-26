import 'dart:math';

import 'package:fab_filter/list_item_lines.dart';
import 'package:fab_filter/list_item_main_content.dart';
import 'package:fab_filter/list_item_table.dart';
import 'package:fab_filter/list_item_table_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {

  // final double horizontalMargin;
  // final double verticalPadding;

  ListItem({
    Key key,
    // this.horizontalMargin = 16,
    // this.verticalPadding = 24,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _expansionAnimation;
  Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
    _expansionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1 / 4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    // return Text("hi");

    // return Container(
    //   margin: const EdgeInsets.all(8.0),
    //   color: Colors.red,
    //   height: 100,
    // );

    return Container(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: AnimatedBuilder(
                  animation: _expansionAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: RotationTransition(
                              turns: _rotationAnimation,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).primaryColorLight,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ListItemLines(),
                        ],
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   heightFactor: _controller.value,
                      //   child: SizedBox(height: 8,),
                      // ),
                      ClipRect(
                        key: ValueKey(_expansionAnimation.value),
                        child: AnimatedBuilder(
                          animation: _expansionAnimation,
                          builder: (context, child) => Align(
                            alignment: Alignment.topCenter,
                            heightFactor: _expansionAnimation.value,
                            child: const ListItemTable(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  builder: (context, child) => Container(
                    width: double.infinity,
                    // width: mq.width * 0.9,
                    // -
                    //  +
                    // (_expansionAnimation.value *
                    //     mq.width *
                    //     0.05),
                    margin: EdgeInsets.symmetric(
                      horizontal: _expansionAnimation.value * -12 + 12,
                      // vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Container(
                      child: child,
                    ),
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
