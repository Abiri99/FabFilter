import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifier/filters_change_notifier.dart';
import 'filter_view.dart';
import 'filter_view2.dart';

class FilterPageViewContainer extends StatelessWidget {
  
  final Animation<double> filterSheetAnimation;
  
  FilterPageViewContainer(this.filterSheetAnimation);
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 36 * (1 - filterSheetAnimation.value)),
      child: Opacity(
        opacity: filterSheetAnimation.value,
        child: ChangeNotifierProvider(
          create: (context) => FiltersChangeNotifier(),
          child: Consumer<FiltersChangeNotifier>(
            builder: (_, filtersChangeNotifier, __) => Container(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: filtersChangeNotifier.filters.length,
                itemBuilder: (context, position) {
                  return filtersChangeNotifier.filters[position]["type"] == 2 ? FilterView2(
                    key: ValueKey(filtersChangeNotifier.filters[position]["status"]),
                  ) : FilterView(
                    filtersChangeNotifier: filtersChangeNotifier,
                    position: position,
                    key: ValueKey(filtersChangeNotifier.filters[position]["status"]),
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
