import 'dart:math';

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
    this.verticalPadding = 16,
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
        builder: (context, child) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: widget.horizontalMargin - _expansionAnimation.value * 8,
            vertical: 8,
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
          child: Column(
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: _expansionAnimation.value * (pi / 2),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColorLight,
                      size: 16,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Line(
                                color: Theme.of(context).primaryColorLight,
                                height: 10,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Line(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                                height: 10,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              flex: 2,
                              child: Line(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                                height: 10,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   heightFactor: _controller.value,
              //   child: SizedBox(height: 8,),
              // ),
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _controller.value,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 24,
                    ),
                    // itemExtent: 24,
                    children: [
                      ListItemTableRow(withBackgroundColor: false,),
                      ListItemTableRow(withBackgroundColor: true,),
                      ListItemTableRow(withBackgroundColor: false,),
                      ListItemTableRow(withBackgroundColor: true,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
