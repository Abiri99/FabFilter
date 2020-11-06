import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_view.dart';
import '../filter_view2.dart';

class FPV extends StatefulWidget {
  final AnimationController filterAnimationController;
  final AnimationController animationController;

  final PageController pageController;

  // final Animation<double> filterSheetAnimation;
  // final Animation<double> fadeOutAnimation;
  final double topIndicatorListViewHeight;
  final double fpvHeight;

  FPV({
    Key key,
    @required this.pageController,
    @required this.animationController,
    @required this.filterAnimationController,
    // @required this.filterSheetAnimation,
    // @required this.fadeOutAnimation,
    @required this.topIndicatorListViewHeight,
    @required this.fpvHeight,
  })  : assert(pageController != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        // assert(filterSheetAnimation != null),
        // assert(fadeOutAnimation != null),
        assert(topIndicatorListViewHeight != null),
        assert(fpvHeight != null),
        super(key: key);

  @override
  FPVState createState() => FPVState();
}

class FPVState extends State<FPV> {

  Animation<double> fadeInAnimation;
  Animation<double> fadeOutAnimation;

  @override
  void initState() {
    fadeInAnimation = CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeOut,
      ),
    );
    fadeOutAnimation = CurvedAnimation(
      parent: widget.filterAnimationController,
      curve: Interval(
        0.0,
        0.1,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: fadeInAnimation.value == 1.0 ? false : true,
      child: Opacity(
        opacity:
            fadeInAnimation.value - fadeOutAnimation.value,
        child: Container(
          // color: Colors.white38,
          // Todo: fix this height
          height: widget.fpvHeight,
          // color: Colors.red,
          child: Transform.translate(
            offset: Offset(0, 36 * (1 - fadeInAnimation.value)),
            child: Consumer<FiltersChangeNotifier>(
              builder: (_, filtersChangeNotifier, __) => PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: widget.pageController,
                itemCount: filtersChangeNotifier.filters.length,
                itemBuilder: (context, position) {
                  return filtersChangeNotifier.filters
                              .elementAt(position)
                              .runtimeType ==
                          Filter2ChangeNotifier
                      ? ChangeNotifierProvider.value(
                          value: filtersChangeNotifier.filters[position]
                              as Filter2ChangeNotifier,
                          child: Consumer<Filter2ChangeNotifier>(
                            builder: (context, fcn, __) => FilterView2(
                              fcn: fcn,
                              // key: ValueKey(
                              // filtersChangeNotifier
                              //         .filters[position]
                              //     ["status"],
                              // ),
                            ),
                          ),
                        )
                      : ChangeNotifierProvider.value(
                          value: filtersChangeNotifier.filters[position]
                              as Filter1ChangeNotifier,
                          child: Consumer<Filter1ChangeNotifier>(
                            builder: (context, fcn, __) => FilterView(
                              fcn: fcn,
                              position: position,
                              // key: ValueKey(
                              //   filtersChangeNotifier
                              //           .filters[position]
                              //       ["status"],
                              // ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
