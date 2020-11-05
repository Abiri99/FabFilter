import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_view.dart';
import '../filter_view2.dart';

class FPV extends StatefulWidget {
  final PageController pageController;
  final Animation<double> filterSheetAnimation;
  final Animation<double> fadeOutAnimation;
  final double topIndicatorListViewHeight;
  final double fpvHeight;

  FPV({
    Key key,
    @required this.pageController,
    @required this.filterSheetAnimation,
    @required this.fadeOutAnimation,
    @required this.topIndicatorListViewHeight,
    @required this.fpvHeight,
  })  : assert(pageController != null),
        assert(filterSheetAnimation != null),
        assert(fadeOutAnimation != null),
        assert(topIndicatorListViewHeight != null),
        assert(fpvHeight != null),
        super(key: key);

  @override
  FPVState createState() => FPVState();
}

class FPVState extends State<FPV> {
  animationListener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.filterSheetAnimation.addListener(animationListener);
    widget.fadeOutAnimation.addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.filterSheetAnimation.removeListener(animationListener);
    widget.fadeOutAnimation.removeListener(animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.filterSheetAnimation.value == 1.0 ? false : true,
      child: Opacity(
        opacity: widget.filterSheetAnimation.value - widget.fadeOutAnimation.value,
        child: Container(
          // color: Colors.white38,
          // Todo: fix this height
          height: widget.fpvHeight,
          // color: Colors.red,
          child: Transform.translate(
            offset: Offset(0, 36 * (1 - widget.filterSheetAnimation.value)),
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
