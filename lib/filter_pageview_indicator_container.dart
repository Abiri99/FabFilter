import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier/filters_change_notifier.dart';
import 'filter_pageview_indicator.dart';

class FilterPageViewIndicatorContainer extends StatelessWidget {
  final Animation<double> filterSheetAnimation;
  final BoxConstraints constraints;

  FilterPageViewIndicatorContainer({
    this.filterSheetAnimation,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (1 - filterSheetAnimation.value) * 64 + 0,
      left: 0,
      right: 0,
      bottom:
          constraints.maxHeight - 64 - ((1 - filterSheetAnimation.value) * 64),
      child: IgnorePointer(
        ignoring: false,
        child: Opacity(
          opacity: filterSheetAnimation.value == 0 ? 0.0 : 1.0,
          child: ChangeNotifierProvider(
            create: (context) => FiltersChangeNotifier(),
            child: Container(
              alignment: Alignment.center,
              color: Color(0xff164A6D),
              child: FilterPageViewIndicator(
                currentPage: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
