import 'package:fab_filter/line.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double percent =
            (constraints.maxHeight - minExtent) / (maxExtent - minExtent);

        return Container(
          color: Theme.of(context).primaryColor,
          height: constraints.maxHeight,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewInsets.top,
          ),
          child: Stack(
            alignment: Alignment.center,
            // fit: StackFit.expand,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: Transform.scale(
                  scale: ((percent * 1.0) + 0.8),
                  child: Line(
                    width: 80,
                    height: 10,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                // top: MediaQuery.of(context).viewPadding.top,
                bottom: 0,
                top: (-200 * (1 - percent)/2) + MediaQuery.of(context).viewPadding.top,
                child: Transform.scale(
                  scale: 1.0 - (1 - percent) * 0.8,
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      color: Theme.of(context).primaryColorLight,
                      iconSize: 34,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 65.0;
}
