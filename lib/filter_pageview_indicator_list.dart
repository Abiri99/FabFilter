import 'package:fab_filter/change_notifier/base_change_notifier.dart';
import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:fab_filter/filter_pageview_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String TAG = "FilterPageViewIndicatorList";

class FilterPageViewIndicatorList extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int page) pageChangeCallback;
  final double currentPage;

  FilterPageViewIndicatorList({
    Key key,
    @required this.scrollController,
    @required this.pageChangeCallback,
    @required this.currentPage,
  })  : assert(scrollController != null),
        assert(pageChangeCallback != null),
        assert(currentPage != null),
        super(key: key);

  @override
  _FilterPageViewIndicatorListState createState() =>
      _FilterPageViewIndicatorListState();
}

class _FilterPageViewIndicatorListState
    extends State<FilterPageViewIndicatorList> {
  animateToItem(int position) {
    widget.scrollController.animateTo(
      (position.toDouble() * 116),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    widget.pageChangeCallback(position);
  }

  @override
  Widget build(BuildContext context) {
    FiltersChangeNotifier filtersChangeNotifier =
        Provider.of<FiltersChangeNotifier>(context);
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: widget.scrollController,
        padding: EdgeInsets.only(
            left: 24, right: MediaQuery.of(context).size.width - 144),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filtersChangeNotifier.filters.length,
        itemBuilder: (context, position) {
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () {
                animateToItem(position);
              },
              child: Transform.scale(
                scale: 1 -
                    (0.1 * (widget.currentPage - position).clamp(-1, 1).abs()),
                // scale: (1 - (widget.currentPage - position).clamp(-0.2, 0.2).abs()),
                child: ChangeNotifierProvider.value(
                  value: filtersChangeNotifier.filters.elementAt(position) as BaseChangeNotifier,
                  child: Consumer<BaseChangeNotifier>(
                    builder: (context, fcn, __) => FilterPageViewIndicator(
                      fcn: fcn,
                      opacity: (1 - (widget.currentPage - position).abs()).clamp(0.2, 1.0),
                      filterStatus: fcn.status,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
