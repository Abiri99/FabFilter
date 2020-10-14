import 'dart:math';

import 'package:fab_filter/list_item_main_content.dart';
import 'package:fab_filter/list_item_table.dart';
import 'package:fab_filter/list_item_table_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'line.dart';

class ListItem extends StatefulWidget {
  final double horizontalMargin;
  final double verticalPadding;

  ListItem({
    Key key,
    this.horizontalMargin = 16,
    this.verticalPadding = 24,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _expansionAnimation;

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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _expansionAnimation,
        builder: (context, child) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9 - widget.horizontalMargin + (_controller.value * MediaQuery.of(context).size.width * 0.05),
              margin: EdgeInsets.symmetric(
                // horizontal: widget.horizontalMargin - _expansionAnimation.value * 8,
                vertical: 10,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: widget.verticalPadding,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: ListItemMainContent(
                controller: _controller,
                expansionAnimation: _expansionAnimation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
