import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_pageview_indicator_list.dart';

class PageViewIndicators extends StatefulWidget {
  final Function animateToPage;
  final BoxConstraints constraints;
  final ScrollController scrollController;

  PageViewIndicators({
    Key key,
    @required this.constraints,
    @required this.animateToPage,
    @required this.scrollController,
  })  : assert(animateToPage != null),
        assert(constraints != null),
        assert(scrollController != null),
        super(key: key);

  @override
  PageViewIndicatorsState createState() => PageViewIndicatorsState();
}

class PageViewIndicatorsState extends State<PageViewIndicators> {
  double fadeOutAnimationValue;
  double filterSheetAnimationValue;

  setFadeOutAnimationValue(double value) {
    setState(() {
      this.fadeOutAnimationValue = value;
    });
  }

  setFilterSheetAnimation(double value) {
    setState(() {
      this.filterSheetAnimationValue = value;
    });
  }

  @override
  void initState() {
    fadeOutAnimationValue = 0.0;
    filterSheetAnimationValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersChangeNotifier>(
      builder: (context, fcn, __) => Positioned(
        top: (1 - filterSheetAnimationValue) * 64 + 0,
        left: 0,
        right: 0,
        bottom: widget.constraints.maxHeight -
            64 -
            ((1 - filterSheetAnimationValue) * 86),
        child: IgnorePointer(
          ignoring: filterSheetAnimationValue == 0 ? true : false,
          child: Opacity(
            opacity: filterSheetAnimationValue == 0 ? 0.0 : 1.0,
            child: ChangeNotifierProvider.value(
              value: fcn,
              child: Opacity(
                opacity: 1 - fadeOutAnimationValue,
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xff164A6D),
                  child: FilterPageViewIndicatorList(
                    scrollController: widget.scrollController,
                    currentPage: fcn.currentPage,
                    pageChangeCallback: widget.animateToPage,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
