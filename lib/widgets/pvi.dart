import 'package:fab_filter/change_notifier/filters_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_pageview_indicator_list.dart';

class PVI extends StatefulWidget {
  final ScrollController scrollController;
  final Function animateToPage;
  final double topIndicatorListHeight;
  final double fpvHeight;

  final AnimationController animationController;
  final AnimationController filterAnimationController;

  // final Animation<double> filterSheetAnimation;
  // final Animation<double> fadeOutAnimation;

  PVI({
    Key key,
    @required this.animationController,
    @required this.filterAnimationController,
    // @required this.filterSheetAnimation,
    // @required this.fadeOutAnimation,
    @required this.topIndicatorListHeight,
    @required this.fpvHeight,
    @required this.scrollController,
    @required this.animateToPage,
  })  : assert(topIndicatorListHeight != null),
        assert(scrollController != null),
        assert(animateToPage != null),
        assert(animationController != null),
        assert(filterAnimationController != null),
        // assert(filterSheetAnimation != null),
        // assert(fadeOutAnimation != null),
        assert(fpvHeight != null),
        super(key: key);

  // : filterSheetAnimation = CurvedAnimation(
  //     parent: controller,
  //     curve: Interval(
  //       0.7,
  //       1.0,
  //       curve: Curves.easeOut,
  //     ),
  //   ),
  //   fadeOutAnimation = null;

  @override
  _PVIState createState() => _PVIState();
}

class _PVIState extends State<PVI> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("built...");
    return Positioned(
      bottom: widget.fpvHeight -
          (1 - fadeInAnimation.value) *
              widget.topIndicatorListHeight,
      child: Consumer<FiltersChangeNotifier>(
        builder: (context, fcn, __) => Container(
          height: widget.topIndicatorListHeight,
          child: IgnorePointer(
            ignoring: fadeInAnimation.value == 0,
            child: Opacity(
              opacity: fadeInAnimation.value == 0
                  ? 0.0
                  : 1.0 - fadeOutAnimation.value,
              child: ChangeNotifierProvider.value(
                value: fcn,
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
    // return Consumer<FiltersChangeNotifier>(
    //   builder: (context, fcn, __) => Positioned(
    //     top: (1 - filterSheetAnimationValue) * 64 + 0,
    //     left: 0,
    //     right: 0,
    //     bottom: widget.constraints.maxHeight -
    //         64 -
    //         ((1 - filterSheetAnimationValue) * 86),
    //     child: IgnorePointer(
    //       ignoring: filterSheetAnimationValue == 0 ? true : false,
    //       child: Opacity(
    //         opacity: filterSheetAnimationValue == 0 ? 0.0 : 1.0,
    //         child: ChangeNotifierProvider.value(
    //           value: fcn,
    //           child: Opacity(
    //             opacity: 1 - fadeOutAnimationValue,
    //             child: Container(
    //               alignment: Alignment.center,
    //               color: Color(0xff164A6D),
    //               child: FilterPageViewIndicatorList(
    //                 scrollController: widget.scrollController,
    //                 currentPage: fcn.currentPage,
    //                 pageChangeCallback: widget.animateToPage,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // return Container(
    //   height: widget.controller.value * 200 + 100,
    //   color: Colors.red,
    // );

    // return widget.controller.isAnimating
    //     ? AnimatedBuilder(
    //         animation: widget.controller,
    //         builder: buildLayout(),
    //       )
    //     : AnimatedBuilder(
    //         animation: widget.secondController,
    //         builder: (context, child) => Container(
    //           color: Colors.grey,
    //           height: 50,
    //         ),
    //       );

    // return AnimatedBuilder(
    //   key: ValueKey(widget.controller),
    //   animation: widget.controller,
    //   builder: (context, child) => buildLayout(),
    // );
  }
}
