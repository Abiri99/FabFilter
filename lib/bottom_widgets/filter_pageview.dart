import 'package:fab_filter/change_notifier/filter1_change_notifier.dart';
import 'package:fab_filter/change_notifier/filter2_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_view.dart';
import '../filter_view2.dart';

class FilterPageView extends StatefulWidget {
  final PageController pageController;

  FilterPageView({
    Key key,
    @required this.pageController,
  })  : assert(pageController != null),
        super(key: key);

  @override
  FilterPageViewState createState() => FilterPageViewState();
}

class FilterPageViewState extends State<FilterPageView> {

  double filterSheetAnimationValue;
  setFilterSheetAnimationValue(double value) {
    setState(() {
      this.filterSheetAnimationValue = value;
    });
  }

  double fadeOutAnimationValue;
  setFadeOutAnimationValue(double value) {
    setState(() {
      this.fadeOutAnimationValue = value;
    });
  }

  @override
  void initState() {
    filterSheetAnimationValue = 0.0;
    fadeOutAnimationValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: filterSheetAnimationValue == 1.0 ? false : true,
      child: Transform.translate(
        offset: Offset(0, 36 * (1 - filterSheetAnimationValue)),
        child: Opacity(
          opacity: filterSheetAnimationValue,
          child: Consumer<FiltersChangeNotifier>(
            builder: (_, filtersChangeNotifier, __) => Opacity(
              opacity: 1 - fadeOutAnimationValue,
              child: Container(
                child: PageView.builder(
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
      ),
    );
  }
}
