import 'package:flutter/material.dart';

import 'line.dart';

class ListItemMainContent extends StatelessWidget {

  const ListItemMainContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
