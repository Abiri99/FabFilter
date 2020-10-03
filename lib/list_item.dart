import 'package:flutter/material.dart';

import 'line.dart';

class ListItem extends StatelessWidget {
  final double horizontalMargin;

  ListItem({
    this.horizontalMargin = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColorLight,
            size: 16,
          ),
          SizedBox(
            width: 8,
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
    );
  }
}
