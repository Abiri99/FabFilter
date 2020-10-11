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
        print("percent: $percent");
        print("maxHeight: ${constraints.maxHeight}");

        print("top: ${MediaQuery.of(context).viewPadding.top}");

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
                child: Line(
                  width: 180 - (1 - percent) * 60,
                  height: 12,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              Positioned(
                left: 16,
                // top: MediaQuery.of(context).viewPadding.top,
                bottom: 0,
                top: (-200 * (1 - percent)/2) + MediaQuery.of(context).viewPadding.top,
                child: Container(
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).primaryColorLight,
                    size: 32,
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
