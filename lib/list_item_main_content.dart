import 'dart:math';

import 'package:fab_filter/list_item_table.dart';
import 'package:flutter/material.dart';

import 'line.dart';

class ListItemMainContent extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> expansionAnimation;

  const ListItemMainContent({
    this.controller,
    this.expansionAnimation,
  })  : assert(controller != null),
        assert(expansionAnimation != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IgnorePointer(
          child: Row(
            children: [
              Transform.rotate(
                angle: expansionAnimation.value * (pi / 2),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColorLight,
                  size: 16,
                ),
              ),
              const SizedBox(
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
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   heightFactor: _controller.value,
        //   child: SizedBox(height: 8,),
        // ),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: controller.value,
            child: const ListItemTable(),
          ),
        ),
      ],
    );
  }
}
